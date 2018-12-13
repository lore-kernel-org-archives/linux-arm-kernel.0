Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CBAC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:31:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B71F204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YWcBwAn4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="woOE716y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B71F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=u2MNj3tzy8jjUJ+2eegQ2bZlnULn1hVGrG1sw9mfAG8=; b=YWcBwAn4LTmdAfqvr/mdBifJD
	meJmJ9lwZoKxR4bH44iJQg/I62GfHMDWOVpSFkuDz29uFZoIyz2gC/wm83TpMZnhq580wB4UwyTp/
	Ez/Jq0d0jWa0M74JyOHF6Jc3pyLV8iS5jNF7R4vSGnOC61x4Qqks4lCNL/fjLWEt5f/RTuZVYteV5
	DsQ4bqrjVqNnHuVvysD7J9F7u7K6aeZ6HOQui67JNDfzIHcM++vLk+NZ9TUjsu4nIROJuBRGHmlx7
	way/0boWY+p37hBFwobMnttV8+cJmURKtpP9IO6Pfo+Lz352X6kNxKBvtAZyWkehocL2ZXOpAzt55
	L1+AyVv7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXSxl-0003Ek-P8; Thu, 13 Dec 2018 15:31:45 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXSxi-00032b-G2
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 15:31:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aMi9RppRMGrt48yb6riDizpSKO27weat1ADl7FM93Gs=; b=woOE716yUQmMCt6N90z08oOKL
 xDAEpl8UY2G2tGmJdpHJgE09ZQJJXT2zBJX9ErFDny7Kg324txItCFSH3ojQ5gMLPLS3Z7xLO/zXw
 rMdGdrL2o4vA3VAGaKaegTY7T2QNsZo1CHAAZC6DibkoAz0SL8mlTwyTPgMYW4+mlIsbw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gXSxT-0001hf-Lp; Thu, 13 Dec 2018 15:31:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 4F4FE11254D1; Thu, 13 Dec 2018 15:31:27 +0000 (GMT)
Date: Thu, 13 Dec 2018 15:31:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: Re: [PATCH 2/3] ASoC: xlnx: Add i2s driver
Message-ID: <20181213153127.GN10669@sirena.org.uk>
References: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_073142_687397_8422DEB5 
X-CRM114-Status: UNSURE (   9.26  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Jaroslav Kysela <perex@perex.cz>, Michal Simek <michal.simek@xilinx.com>,
 Vishal Sagar <vsagar@xilinx.com>
Content-Type: multipart/mixed; boundary="===============7086674818115775603=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7086674818115775603==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o+ZCuNqY+dEAKBWl"
Content-Disposition: inline


--o+ZCuNqY+dEAKBWl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 08, 2018 at 12:02:37AM +0530, Maruthi Srinivas Bayyavarapu wrote:

> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx ASoC I2S audio support
> + *

This looks otherwise good so I've applied it but please send a followup
patch converting the entire comment block to C++ style so this looks
more consistent.

--o+ZCuNqY+dEAKBWl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSe04ACgkQJNaLcl1U
h9AApQf/ZYZreo/i4fqhX4ZisqCS87wTmjedquBnDbFr4A908f5mKat+VrZEor9g
qfdXB6YMTRb1BPFQrFqv93f/OxjbZeM7Gztv8B7n7shGQ9Oh1Xg0pPLYSsvZLZEm
ZTt2TwTyXgm2A0xiiLbTuXlin/tilgBcNUK2GvMPaD0vEftBJJplV+WkxTe71U4F
T5Umnu41+7kcm0EGdNyIu2q1/NZAVkvvyZGKeJtRIHNdT6XKbczxHsN/tDp8Xalv
LqTlJiSNDOsG+G5zKuTZc3Ae1M8sx3NNWs3Tybe0dyC3tbuGiny6pNkkOYNs2OoV
rxwnrk5IqefawbCi6uDMdfNRXwMvxQ==
=36PQ
-----END PGP SIGNATURE-----

--o+ZCuNqY+dEAKBWl--


--===============7086674818115775603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7086674818115775603==--

