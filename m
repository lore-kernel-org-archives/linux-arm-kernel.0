Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376D0C41518
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:18:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F6420866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OgxSGNX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F6420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NyA+FPBQ3UHfFOnrqZ0y//hJirm3gNrEqxB+hXJ0Gtc=; b=OgxSGNX3atWiwgIIJBLpR2RGS
	N4lvGmptunvWKLIEEqVYcdU3v+4/etHiQ0FRRYtkENiw+w8vCfv9oUzVBiaYf5vQEhB0F6VuxgETZ
	i0JqUgeKQ/CLlrxXLJFgdgBvV/Lfx2abxfjTlAoHLfWHYbna9izvW1jGqtj8uwNynsYdzyw1hRU7A
	DssW2yJem2fmwhclGFSgB7Mp7LVqYBzT8ZViOE2gXbq4p0l5rZ+8krMcXDHOSJCI1scf7g4lukzKj
	hUVOJqrzuShqqvIjURv9cQ+CaOE+JpUqBGB3sHVX4KKy6mIBcmcmBa8Q9keWj01tCihVFqBjskNpR
	A73lQyHNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm5Jq-0000UZ-6c; Tue, 22 Jan 2019 23:18:58 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm5Jn-0000U6-GT
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 23:18:56 +0000
Received: from localhost (p54B333AA.dip0.t-ipconnect.de [84.179.51.170])
 by pokefinder.org (Postfix) with ESMTPSA id A084A2C78FF;
 Wed, 23 Jan 2019 00:18:54 +0100 (CET)
Date: Wed, 23 Jan 2019 00:18:54 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH] i2c: aspeed: Remove hard-coded bus timeout value setting
Message-ID: <20190122231854.g75ijhg6halhzdvh@ninjato>
References: <20190116193943.6004-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20190116193943.6004-1-jae.hyun.yoo@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_151855_696184_13F9FC5F 
X-CRM114-Status: UNSURE (   5.86  )
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
Cc: linux-aspeed@lists.ozlabs.org, James Feist <james.feist@linux.intel.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, openbmc@lists.ozlabs.org,
 Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, Joel Stanley <joel@jms.id.au>,
 Vernon Mauery <vernon.mauery@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============7820268808400553527=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7820268808400553527==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n33otukcn44nvdcc"
Content-Disposition: inline


--n33otukcn44nvdcc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019 at 11:39:43AM -0800, Jae Hyun Yoo wrote:
> This commit removes hard-coded bus timeout value setting so that
> it can be set by i2c-core-base.
>=20
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Applied to for-next, thanks!


--n33otukcn44nvdcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxHpN0ACgkQFA3kzBSg
KbY1fw/9H06zwh4pL8+szV13WMpPIU1rXCyiRitiy1m4Q6GgfHgyNUyjAAeuNmO/
TcwZNmGx4yGlonk7LmL1xg98w7mjcbAwwu4B5ihlPN28MJGGT+WIdpHibjzB8Dvz
Qwqh23tWxaU0KtMRwZppKKbKv5T8jux6qarxfxVFDY5eEd8qSWiqRCzN/5i9pE3Y
gVpxKi5cQwSANEveQ9rjLU+tqq+VNo48PlcybHMaVImGL8V9lDVOKwosoQnISJ71
Wnx+FfX0f/Mlu00gIcB/LrPnz4JbWRLvvyTr8RRtjJXHEmaicIncj6vmGvLp8m3l
NsUAalTrwdDJq9EzzTRYNhlDlkUEonESnIlaQmjgSGKLYJ3u8sO1vL6P7SNfYRbu
dP7O/e0eZFlovb+6XnF21arafl/J8bN4Qv0MLgm3/kUWxcmw6MpDBoiQ58eLn0et
hFG4AJCWNszEA1btFdt+kR2VSl65+6rHydDqJIP7aDwnoXVYqIJjYjs79tHbs+jS
jIKvcIpXvzMpPwQ4W7pO9QwqCfDDadnKuOoFpe2L59a+OYT6orTNqfl3kSRey7sv
9WfLkus8l7nZovpkeXW9vwkEUvdC3xQX5f6eIiKiB4is7uArt5cZmH7BHQOiypX0
jh0pSX9f6dI9eDCMq/VGzOysDHitI6K+E/0tiv6wFAycN/IVIfg=
=nQmG
-----END PGP SIGNATURE-----

--n33otukcn44nvdcc--


--===============7820268808400553527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7820268808400553527==--

