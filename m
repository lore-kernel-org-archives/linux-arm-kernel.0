Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96582C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:24:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F82320818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pS0SkC6f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="sPsU5EMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F82320818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FMc9EqifnX0EuP8rTKJ3xlF2TnMLBMSixr5SQEBenVM=; b=pS0SkC6fN5sezSwSbLwLj21zN
	l/VSQzj16t2it1twTSpCao0xWhgWmogJRu6RpamugOjQJyGNgHC1h0i1AhzN96nhCynjY4y9O8Hh3
	4rxFk3k9UqkiasHmuWDjpFYXewFUQzR7uuap22Rloxm2Jc57Qz2Y+WYIXrBJsQqJ68owNU0PNN0Kf
	467Edhb3UNSSUvAHEDKjjnLHWahuwzg5NPaM2kog6eYB6YMzkPi8xH0DtVqG5CfEiYr3qFTsdxFnB
	JC3iffB/m6hPVeLRhYuF4Er5DsZ1ukiPTuw07f58Cy+z+G+xIm6ixrHtau296E4o/kAQeIKgyf/3k
	T9gBvGEbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpx9B-0004nO-8G; Sat, 02 Feb 2019 15:23:57 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpx97-0004n3-6L
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 15:23:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I9/JZlnq2N8rh4U3EZjlUbv7HbaTh7zlNjpL/wdd2QE=; b=sPsU5EMR8CQcQcH9kkRJcpXBB
 Y12HP+MB0bL6AO1TE8W6mlusXpMyjZ3M3HFBu0SVLyKahn2ylgc77hDclvpsNHjCRTZDrENaLHdtE
 mGT5bUYDifG1iI+7EOXR6kB72vwlGyM5ncb3B+QZbdEALfHI3ijB7DVotlPC4yKt4rrdo=;
Received: from [2001:67c:1810:f055:877d:5801:eba7:24a1]
 (helo=finisterre.ee.mobilebroadband)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gpx90-0007NF-RB; Sat, 02 Feb 2019 15:23:46 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
 id 86287440082; Sat,  2 Feb 2019 15:23:40 +0000 (GMT)
Date: Sat, 2 Feb 2019 15:23:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <treding@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: next-20190201 build: 2 failures 19 warnings (next-20190201)
Message-ID: <20190202152340.GJ20797@sirena.org.uk>
References: <E1gpgTf-0002ZN-NF@optimist>
MIME-Version: 1.0
In-Reply-To: <E1gpgTf-0002ZN-NF@optimist>
X-Cookie: What!?  Me worry?
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_072353_401553_C20297F1 
X-CRM114-Status: UNSURE (   7.00  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-tegra@vger.kernel.org, linaro-kernel@lists.linaro.org,
 linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-build-reports@lists.linaro.org
Content-Type: multipart/mixed; boundary="===============6822374599801915661=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6822374599801915661==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Content-Disposition: inline


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 01, 2019 at 09:35:59PM +0000, Build bot for Mark Brown wrote:

Friday's -next fails to build an arm64 allmodconfig due to (among other
things):

> 	arm64-allmodconfig
> ERROR: "mbox_flush" [drivers/tty/serial/tegra-tcu.ko] undefined!

since that symbol isn't exported by the mailbox API.  Either the driver
shouldn't be using it or we need an EXPORT_SYMBOL_GPL() adding.

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxVtfgACgkQJNaLcl1U
h9BsKAf/Z6iYF+BgN8DfIusRTt8yh7ByRZhzG/sbm/VGBbavEWTm3aYiYqQxqvAW
kBBM4m4+bLTtq5YJuDVbc3eycZHYVcVkfz8COH2jtg+Q5PbCmJUrR1o0QAzebBAe
wuwqPgitfFKY0tbwl3cR+HkW75iZTGiV/S7gyU10qZMbHga/ggMQAWqnnVgcdKkI
H3oZijOAI734uNepeFgHn4xhI0gn5KQyOFaTe6aE15cWQMPW1b64b99P+rnNwQin
UfO+2ZRtj40mm/+fnVJSTHAy0k3qRtPdpXDD4KdM8pOAWNl3Tw35Ba103g+phuom
y6EKFaSlL3YGQD5P/D3W1kdamn3dSw==
=3mWK
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--


--===============6822374599801915661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6822374599801915661==--

