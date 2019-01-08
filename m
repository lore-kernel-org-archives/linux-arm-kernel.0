Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D2CC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:09:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2665120660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XPETlbAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2665120660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uejllwtK9DxdvZdpUPntISohggjSAu7X0O8vxbFo2Bg=; b=XPETlbAzazNXC6hErZ5aBx2Uu
	yjrl+2ZgMpALzz2kcgTB84vaGzy6O4eQxMwyBVkQXa92VgDFHwnYEd8pUG/6v5MGJnsliYBBtUJFA
	slVGscJ67NJ/u9vRUL9a1UScU6jaeKBuxRTOi+Y5+pGacaT1pxKWiIyTCNhBorCdA0ttNKdMqoF2c
	Ir9xRUTR/CW6NWS5wCV+3JwkDyxPXKBFGsMBckQ+Hwcou7q+nwRolG/0DaLffMFNKkCTD00QiRjRO
	X+lVkwWDVR0E3hYDSyU3/iO56ATPgf0vaBsZj2PDuwOaZ0oVw/Y7UYuVl+FVqHCMvRXEr2uapMVi3
	jQ7po5sqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggxh5-0001sU-0r; Tue, 08 Jan 2019 20:09:47 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggxh0-0001rm-2Y
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 20:09:45 +0000
Received: from localhost (p54B337DA.dip0.t-ipconnect.de [84.179.55.218])
 by pokefinder.org (Postfix) with ESMTPSA id 7E82B3E48B8;
 Tue,  8 Jan 2019 21:09:38 +0100 (CET)
Date: Tue, 8 Jan 2019 21:09:38 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 00/10] i2c: move handling of suspended adapters to the core
Message-ID: <20190108200937.bratvsbz4grk6m4e@ninjato>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
In-Reply-To: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_120942_415244_1E3A1D86 
X-CRM114-Status: GOOD (  13.55  )
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
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3705682281302399847=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3705682281302399847==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mwtdafiryfs7cnw6"
Content-Disposition: inline


--mwtdafiryfs7cnw6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 05:48:16PM +0100, Wolfram Sang wrote:
> Finally, here is the implementation Hans and I agreed on. Plus, all poten=
tial
> users I could spot already converted. Renesas R-Car driver was added on t=
op.
> This series was tested on a Renesas Lager board (R-Car H2). I had to hack=
 some
> error cases into the code to verify the workings. Thanks for all the test=
s so
> far. Of course, more testing never hurts ;)
>=20
> Please comment, review, test... a branch can be found here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/c=
ore-pm-helpers
>=20
> Thanks,
>=20
>    Wolfram
>=20
> Changes since RFC:
>=20
> * don't use bitfields anymore but an unsigned long flags variable which i=
s only
>   meant for flags to be changed when the adapter lock is held
>=20
> * split the genereic accessor into _mark_suspended() and _mark_resumed()
>=20
> * added kerneldoc and noted that using these helpers is optional
>=20
> * documented -ESHUTDOWN as the error code when trying to transfer using an
>   already suspended adapter
>=20
> * added acks from last series. Changes were minor enough to keep them. Pl=
ease let
>   me know if you disagree.
>=20
>=20
> Wolfram Sang (10):
>   i2c: add suspended flag and accessors for i2c adapters
>   i2c: reject new transfers when adapters are suspended
>   i2c: synquacer: remove unused is_suspended flag
>   i2c: brcmstb: use core helper to mark adapter suspended
>   i2c: zx2967: use core helper to mark adapter suspended
>   i2c: sprd: don't use pdev as variable name for struct device *
>   i2c: sprd: use core helper to mark adapter suspended
>   i2c: exynos5: use core helper to mark adapter suspended
>   i2c: s3c2410: use core helper to mark adapter suspended
>   i2c: rcar: add suspend/resume support

After a long road, I applied this series now to for-next. I only
squashed patches 1+2 to have the functionality in one place. And fixed a
typo in patch 1. Thanks to the testers and reviewers, and especially
Hans, for the input and discussions.

This will now get a full test cycle in -next. Let's see what happens...

And let's move on to how to add 'very late transfers without irqs' on
top of this series.

Happy hacking,

   Wolfram


--mwtdafiryfs7cnw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw1A30ACgkQFA3kzBSg
KbbxWw/8CGkkrx9NPVQwRLHRnix2QucE3r9aD0Df5ybapZtzhPdInKj5cJ6rtJjO
Ly0VQzmjKc+6FirBXJKF2Zdu35+/8k4y7owr0oh8fNxRjeWU0Pukp4n9NoX9+CsO
kXyzFEmbx8goTH1zzJgVz1yytO8ebGDCXX086M7D8MDW5ULx0mgzlIWcHkgy81Aj
gUEmnOjbw/JbmeBL0l+gseT2gO5GWArBv/mUFNkuz7pH0AjV/BbkImZ7BuhlYpOV
pvWM2PI2/7xbxpsjFIhIQbOs7hHY1iNkQjONftMT2sjCm8PKFRvf1Il+9K8AA/tp
N13Jn7IGI/lRrxlxGZZ3zr8o715PohfdI4G1OPFpjSorTBs1UV4f8BatsodHk8bh
fAKKjAkPw5/qRcMA8HnkyIrszoM7qCToOYFkBiMtv8+Drdtn5W13HCKL52PGiOds
sE9QS5at1rGWtzQX1fkLpq93GQTyNvFMURJ21YvXnU2U47o1hVLQNQKLQFjNNaLj
k9SOHjoI9xM7PWRgVghphFuUYqQMlHID9GHR1R0bS9uA++CxHzzP4/OTBwTIVBBl
YpTlg4+UtKgmSTWmWR/QSjGAIpRGiAOSIt2mz8YcCF2E9QtLFm2wMTWXxe48Wavt
9n/kVEg/kVdxR2yHZWu5guX3AmiPxUBiZxHhfKCYkrlFUuqL97Y=
=Vtra
-----END PGP SIGNATURE-----

--mwtdafiryfs7cnw6--


--===============3705682281302399847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3705682281302399847==--

