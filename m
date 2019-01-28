Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2808BC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:09:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA162087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qdpOW8/b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6H2XO3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA162087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5sOosMCLpDC3qDpHzTaXtM84Yxy7JUaog5fNFvG99Y4=; b=qdpOW8/b9Qzvt51Cn/FsrnDit
	6HOftlr8E/cGTqU2g8xHogrCOukN5gHPC1KKfxzU5O1Umu8M3xIuzzAggjPA0VoKmCWKfaZ6SIT3C
	NmiNnmmPLA2t+ieTHGa4ZtEVXyGm5CYhm76C5QggC8MsDhzE0mQTNsZYG+33kGNhO+u5WgRc39WW6
	nIB4oOEY/fKETjqSQV13TW2a+mrDpakChtVI0FfgS1yPfmjCE42/uUz0dkBO2yhoq4P+46DZFbk2v
	yGweuDOB+5xTsUVyQEWGGYZiSQShDhhsvksZSVj4J3kAEJL4Jiz5M65kGD5vARJLVhMP1HITK4Jb7
	595gphoMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go8XE-00027z-AX; Mon, 28 Jan 2019 15:09:16 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go8XA-00027c-Tp
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 15:09:14 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so18411955wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 07:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jLRLeJJ4vXgRYRkUNOKN95IL2dl3P67YmfBbj4Dgqi0=;
 b=g6H2XO3ay5npAXtszIVyDrbEzXJvLcxNvM/nNT7uko/Uu3ekJr56zehiwhL6dgah94
 CFyaxMbkzIhnf6SeZlF8/GbNdo0DRVAYNBFp89/xzTtB1iBor81DMBgyJn6I721AY6Kl
 2o5Afov430OIP6HhbUiFDz3IOyEDnYPkRQ85caV2E+nXx6jG0/4KX/RtT+0KY6Ev85AS
 Q+fvSQ2gW5hJ6ckWuLbGh32YKgT75v4EWb4SZ6C5iEnDIP9/Qg16TCD/CZ9ajb9pTicI
 O9Hj1DKkyr/fqK959Q9arR1wcLaNjCRxkQCoVcCsrQLQiNNruWwRp1Aql6E5eYiaabmT
 7ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jLRLeJJ4vXgRYRkUNOKN95IL2dl3P67YmfBbj4Dgqi0=;
 b=mgUtWn5zoLvBMHRrgN4+0jrGSLC50FLpL8tj6xihczAPeOKPVIcXrXtsxtD0vvGK9/
 XAejldrMwNcBCmQqmtM3RRathCzgNMugu7tZq2oBBfL+lN9djITP3/rAQcZstdShYA9f
 f+AAzPNUjuC3qwz0+QGPS0FwYGggIvAozQSaG7czVA84fdYeJGpy/wTYkhwSZ3Bhed/4
 3O7hl8a4NeQR8ZViYiW6lbfdxpEaNp4MlmIi2T1yriLN12jWXQvHZguFZqhskcmNNAzk
 4KJcPR78npVemmqh7yAIs0LoAhbO90dD4n5++z7tHTekZ2GBI9kqulaWVN9atAjkal6k
 bS9A==
X-Gm-Message-State: AJcUukeIdFEPpCweRscRZxet8eHm4tv6jNtD/JPu/9GjwU/uxvX7xshq
 9Ni55rsZL98ig8TduNs0UdY=
X-Google-Smtp-Source: ALg8bN5EvbpcKs5FyQwh+cGZrxdR3rDt9NdbsYU1dxIpgBf7jqAayLIDea4IoyeIZfwCxyQ9ABu6kw==
X-Received: by 2002:adf:fc09:: with SMTP id i9mr21306085wrr.299.1548688151119; 
 Mon, 28 Jan 2019 07:09:11 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id f3sm8023821wmd.22.2019.01.28.07.09.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 07:09:10 -0800 (PST)
Date: Mon, 28 Jan 2019 16:09:08 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V2 2/6] clocksource: tegra: add Tegra210 timer driver
Message-ID: <20190128150908.GB31317@ulmo>
References: <20190128091815.7040-1-josephl@nvidia.com>
 <20190128091815.7040-3-josephl@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20190128091815.7040-3-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_070912_986730_E5B8763D 
X-CRM114-Status: GOOD (  23.55  )
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
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2936377187937137185=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2936377187937137185==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 05:18:11PM +0800, Joseph Lo wrote:
> Add support for the Tegra210 timer that runs at oscillator clock
> (TMR10-TMR13). We need these timers to work as clock event device and to
> replace the ARMv8 architected timer due to it can't survive across the
> power cycle of the CPU core or CPUPORESET signal. So it can't be a wake-up
> source when CPU suspends in power down state.
>=20
> Based on the work of Antti P Miettinen <amiettinen@nvidia.com>
>=20
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> v2:
>  * add error clean-up code
> ---
>  drivers/clocksource/Kconfig          |   3 +
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/timer-tegra210.c | 268 +++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h           |   1 +
>  4 files changed, 273 insertions(+)
>  create mode 100644 drivers/clocksource/timer-tegra210.c
>=20
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a9e26f6a81a1..e6e3e64b6320 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -135,6 +135,9 @@ config TEGRA_TIMER
>  	help
>  	  Enables support for the Tegra driver.
> =20
> +config TEGRA210_TIMER
> +	def_bool ARCH_TEGRA_210_SOC
> +
>  config VT8500_TIMER
>  	bool "VT8500 timer driver" if COMPILE_TEST
>  	depends on HAS_IOMEM
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index cdd210ff89ea..95de59c8a47b 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_SUN4I_TIMER)	+=3D timer-sun4i.o
>  obj-$(CONFIG_SUN5I_HSTIMER)	+=3D timer-sun5i.o
>  obj-$(CONFIG_MESON6_TIMER)	+=3D timer-meson6.o
>  obj-$(CONFIG_TEGRA_TIMER)	+=3D timer-tegra20.o
> +obj-$(CONFIG_TEGRA210_TIMER)	+=3D timer-tegra210.o
>  obj-$(CONFIG_VT8500_TIMER)	+=3D timer-vt8500.o
>  obj-$(CONFIG_NSPIRE_TIMER)	+=3D timer-zevio.o
>  obj-$(CONFIG_BCM_KONA_TIMER)	+=3D bcm_kona_timer.o
> diff --git a/drivers/clocksource/timer-tegra210.c b/drivers/clocksource/t=
imer-tegra210.c
> new file mode 100644
> index 000000000000..477b164e540b
> --- /dev/null
> +++ b/drivers/clocksource/timer-tegra210.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2019, NVIDIA CORPORATION.  All rights reserved.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/percpu.h>
> +#include <linux/syscore_ops.h>
> +
> +static u32 tegra210_timer_freq;
> +static void __iomem *tegra210_timer_reg_base;
> +static u32 usec_config;
> +
> +#define TIMER_PTV		0x0
> +#define TIMER_PTV_EN		BIT(31)
> +#define TIMER_PTV_PER		BIT(30)
> +#define TIMER_PCR		0x4
> +#define TIMER_PCR_INTR_CLR	BIT(30)
> +#define TIMERUS_CNTR_1US	0x10
> +#define TIMERUS_USEC_CFG	0x14
> +
> +#define TIMER10_OFFSET		0x90
> +#define TIMER10_IRQ_IDX		10
> +
> +#define TIMER_FOR_CPU(cpu) (TIMER10_OFFSET + (cpu) * 8)
> +#define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)
> +
> +struct tegra210_clockevent {
> +	struct clock_event_device evt;
> +	char name[20];
> +	void __iomem *reg_base;
> +};
> +#define to_tegra_cevt(p) (container_of(p, struct tegra210_clockevent, ev=
t))
> +
> +static struct tegra210_clockevent __percpu *tegra210_evt;
> +
> +static int tegra210_timer_set_next_event(unsigned long cycles,
> +					 struct clock_event_device *evt)
> +{
> +	struct tegra210_clockevent *tevt;
> +
> +	tevt =3D to_tegra_cevt(evt);
> +	writel(TIMER_PTV_EN |
> +	       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
> +	       tevt->reg_base + TIMER_PTV);
> +
> +	return 0;
> +}
> +
> +static inline void timer_shutdown(struct tegra210_clockevent *tevt)
> +{
> +	writel(0, tevt->reg_base + TIMER_PTV);
> +}
> +
> +static int tegra210_timer_shutdown(struct clock_event_device *evt)
> +{
> +	struct tegra210_clockevent *tevt;
> +
> +	tevt =3D to_tegra_cevt(evt);
> +	timer_shutdown(tevt);
> +
> +	return 0;
> +}
> +
> +static int tegra210_timer_set_periodic(struct clock_event_device *evt)
> +{
> +	struct tegra210_clockevent *tevt;
> +
> +	tevt =3D to_tegra_cevt(evt);
> +	writel(TIMER_PTV_EN | TIMER_PTV_PER | ((tegra210_timer_freq / HZ) - 1),
> +	       tevt->reg_base + TIMER_PTV);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t tegra210_timer_isr(int irq, void *dev_id)
> +{
> +	struct tegra210_clockevent *tevt;
> +
> +	tevt =3D dev_id;
> +	writel(TIMER_PCR_INTR_CLR, tevt->reg_base + TIMER_PCR);
> +	tevt->evt.event_handler(&tevt->evt);
> +
> +	return IRQ_HANDLED;
> +}

Up to here this is a duplicate of timer-tegra20.c. And a lot of
tegra210_timer_init() is the same as tegra20_timer_init() as well. Can't
we unify the two drivers instead?

The power cycle restrictions of the architected timer, do they not apply
to chips earlier than Tegra210 either? So don't we need all of these
additional features on the timer-tegra20.c driver as well? If so that
would increase the code duplication even more. I think we should avoid
that, unless there are any strong arguments that would justify it.

Thierry

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxPGxIACgkQ3SOs138+
s6GwFg/8DJCWHrWuFSOY6LIcYSKi2FK7juvR23Bw/fRwCJg+CWYhGmBi6+ib3sll
xgWA6cvQ6OOv5/fXXswPNKSDXWFPlGS7ujVz24EYqzup6bh832as/XcjXkXfPgsN
pVlhq6CImaxlLEIZscP7N/8FBboIrr6pgXtvw+WjRk+Q5IQ/8IVbFmGtDn6UnA+h
F1CxEA9XbFkpY+UAWlKW0vwi9l5wjAoAuzSfYBBDTGhbYIjj7z9Yza/1hOy2f7eO
2kR35GJDzBGPA13G/aQWqoO8xzF/qv6CZryQT3GJXaTCetGgbPGpEY5IvGDA68fZ
4wvOxOgYAjyrBi4eU43Vq6142hxL2+VQltYpKmwo6VO5FTZoaBT1sLJVlgkglU58
a5nX9JfzI7//oT8xXGYfJYv7ox6MnLIh89y578sEb5zvuhkby+3O0qDR6XiklzRI
asTENLzfgJIbKwalzAAqWpgGvU515uLnbbZ2UbCBBZNlGMDxtFDwuH1u+5IRzkkF
NaY7s8edXJ269UPYiEESP/3cBzhz3zFNJAkK9Por9t4LHceE7C2hnxLaaatdbsUx
wvpH8rbNDjhmv9tL0yyr1U47cadBpjGMF3jBC1/S8NB7p8F5KI+kzz0uNZzeN7r9
HZ7oOEDPQIy8as1LsFFDUZnBuXuN20OkJ71gry/gpkYCr8Nq8u4=
=CZGE
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--


--===============2936377187937137185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2936377187937137185==--

