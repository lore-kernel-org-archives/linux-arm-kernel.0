Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83939C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:05:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE9620840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BPECoCtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE9620840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fIP7aaonVyTojhmJtN+d64p1rTMxYRwQ8JMXuxdWSSw=; b=BPECoCtKfodRwu0sVkpM12Sor
	WARQoDvvADmXcbMy0VAkHYPPzpa7dJ7TDcKZm31sghR26W96+aokTq53V9Riksj6KL5MGPHpVn3py
	uZUhkZLlM8tjVKio+pJAuXK3gxLv454ACt8xdmgG895pL6X9/VD35a5zwJrRy4FsO6/DBoNfxB0DW
	359j/aJfcD8puvcSSZrinc1w17Unknx8kDo+EBHtRDlz0kmQ/YH7zxpobKaH2UdFJDrAiLu/UXgR5
	zb31mZA30pcUv84stjiMWI0SyK/JzDA+8Ynp2BwC9ARL8R9Mig8UiFedloo5tIUaaJbvyHnS1hj6F
	fWyzptVcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjtJV-0000GC-UD; Wed, 16 Jan 2019 22:05:33 +0000
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjtJS-0000Fj-Ga
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 22:05:32 +0000
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id C0B138081B; Wed, 16 Jan 2019 23:05:19 +0100 (CET)
Date: Wed, 16 Jan 2019 23:05:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v2] ARM: tango: Improve ARCH_MULTIPLATFORM compatibility
Message-ID: <20190116220525.GA28781@amd>
References: <48e3596f-4c76-8481-5cd4-5e8e79d31a09@free.fr>
MIME-Version: 1.0
In-Reply-To: <48e3596f-4c76-8481-5cd4-5e8e79d31a09@free.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_140530_714541_EDB459A4 
X-CRM114-Status: GOOD (  13.44  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, arm-soc <arm@kernel.org>,
 Mans Rullgard <mans@mansr.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Paolo Pisati <p.pisati@gmail.com>
Content-Type: multipart/mixed; boundary="===============2179039185869505266=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2179039185869505266==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-01-16 16:49:58, Marc Gonzalez wrote:
> Calling platform-specific code unconditionally blows up when running
> an ARCH_MULTIPLATFORM kernel on a different platform. Don't do it.
>=20
> Reported-by: Paolo Pisati <p.pisati@gmail.com>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifdef CONFIG_SUSPEND
> +void __init tango_pm_init(void);
> +#else
> +#define tango_pm_init NULL
> +#endif
> diff --git a/arch/arm/mach-tango/setup.c b/arch/arm/mach-tango/setup.c
> index 677dd7b5efd9..824f90737b04 100644
> --- a/arch/arm/mach-tango/setup.c
> +++ b/arch/arm/mach-tango/setup.c
> @@ -2,6 +2,7 @@
>  #include <asm/mach/arch.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include "smc.h"
> +#include "pm.h"
> =20
>  static void tango_l2c_write(unsigned long val, unsigned int reg)
>  {
> @@ -15,4 +16,5 @@ DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
>  	.dt_compat	=3D tango_dt_compat,
>  	.l2c_aux_mask	=3D ~0,
>  	.l2c_write_sec	=3D tango_l2c_write,
> +	.init_late	=3D tango_pm_init,
>  MACHINE_END

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw/qqUACgkQMOfwapXb+vIYsACgxN1DgKVvfXeC8nDUmGv+zjtk
cTwAnjm7t1rDlLaj9s+hIEavskUTmBco
=fL7p
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--


--===============2179039185869505266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2179039185869505266==--

