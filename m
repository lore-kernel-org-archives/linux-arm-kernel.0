Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A3BC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:09:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CC0205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MGkUkz1q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mh/agSM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CC0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=69BxII2XDTPh/RJPa+HLEHt9vwgSHIvzsA2CD5M2ahA=; b=MGkUkz1q+RKZBngxiaVsM2wNh
	2W6XjwgByhrzaz9gLpYvlrRCU/B20COiUP9EyGEt2AQoJqpcF63ltKYq99NiHuFOMgYDX8ARB+Vao
	eaZNZoEjfF98mW/OBhO0IdLbl/QfeBsuJoO5dwfHwnEoeggC40wQYthMKsc0G9jzUt4oPbbni0Q6z
	i63cTBv8Jz1sspvmflxDO2Yiosb7jFm4ip4IGn087SK6N8S3mur5wtqnbJLRFuiLPpKfviTr1Lk1a
	Gnk+eouV1S9u0dliI3bApokvoH+g/PG34FwF4Jxm3hqCl3C8IgIIzOW/LsWXX0tiZOkcucXjLcHPR
	Ii9/uJNqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjVxk-00035f-Q0; Tue, 15 Jan 2019 21:09:32 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjVxh-00035L-S7
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 21:09:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s2X22d1LlqDVePqLYmP1rwf2MpuOBw+myHHoyI9YyHk=; b=mh/agSM4jSnUq0H3YM1nkDfP6
 Sxi82ChGz/VUzNWbZLbq0BDYjphGbgdd/uepAF9i2hamiYBVwQ/LDVEH1onD/txd9bpsoJCPbQnWt
 XrCkSJkaeKvNn97ufjo5VDgHK24QdeK2HoTOYKLHZ0XtCcmI/WHbgaMf86mCqGZk2Q0rY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gjVxZ-000327-Hh; Tue, 15 Jan 2019 21:09:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 1C9151127848; Tue, 15 Jan 2019 21:09:21 +0000 (GMT)
Date: Tue, 15 Jan 2019 21:09:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in v5.0-rc with regmap-irq level-irq changes
Message-ID: <20190115210920.GJ5522@sirena.org.uk>
References: <20190115192840.GK5544@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20190115192840.GK5544@atomide.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_130930_053034_075708F0 
X-CRM114-Status: UNSURE (   7.35  )
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org,
 Belisko Marek <marek.belisko@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Tero Kristo <t-kristo@ti.com>, Jon Hunter <jonathanh@nvidia.com>,
 "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 Keerthy <j-keerthy@ti.com>, Thierry Reding <treding@nvidia.com>,
 linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============0656911764090374167=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0656911764090374167==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Content-Disposition: inline


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 11:28:40AM -0800, Tony Lindgren wrote:

> Any ideas what's needed? Some triggering mapping data to palmas.c
> driver?

There should be a fix in -next already waiting for me to send it to
Linus, can you check there (a couple actually, in my for-linus branch)?

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+TAAACgkQJNaLcl1U
h9AwIwf8C1ynMQh1N1yNP3/lscQNBS3K8lg9krjtYsdc+zKtloGVvHZLf8rafYsE
gnWZ8hF5cwMEAkCULG7/iW565WQ5p023DMPmNtk6u9jn3mrbsfk7eYJjapwXrDnL
vXwdJwQra2PVqQzlwjye7R2cg8sVHpt93e2tv1wCETqTqTZNLIrt+CV8qn9JniCG
auqMlP/rGMEjNENMh/rslWbpOrVbWnvWOND8h81q4uqFicr67LTSlwBOOkFom1n5
mlkXLgeFQgsqIaf3T8YVg3vyFmcp1ynTvCKLepDAIDdJyyY6AXbSCL6UoMPkyLQc
L6ks69fcLXODh7IT0NQaCZaYamiI2w==
=0Hrj
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--


--===============0656911764090374167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0656911764090374167==--

