From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 24 Jan 2011 14:25:21 +0530
Subject: [PATCH 5/5] ARM: smp: Skip secondary cpu calibration to speed-up
	boot
In-Reply-To: <1295859080-15259-7-git-send-email-santosh.shilimkar@ti.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-7-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <5b88d3a0315edf957c62a8b34622ae8c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Santosh Shilimkar
> Sent: Monday, January 24, 2011 2:21 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-omap at vger.kernel.org; ccross at android.com;
> catalin.marinas at arm.com; linux at arm.linux.org.uk;
> linus.ml.walleij at gmail.com
> Subject: [PATCH 5/5] ARM: smp: Skip secondary cpu calibration to
> speed-up boot
>
>  	if (!skip_secondary_calibrate) {
>  		for_each_online_cpu(cpu)
> -			bogosum += per_cpu(cpu_data, cpu).loops_per_jiffy;
> +			bogosums += per_cpu(cpu_data,
> cpu).loops_per_jiffy;
>
> -		snprintf(bogosum, sizeof(bogosum), " (%lu.%02lu
> BogoMIPS).\n",
> -			bogosum / (500000/HZ), (bogosum / (5000/HZ)) %
> 100);
> +		snprintf(bogosum, sizeof(bogosums), " (%lu.%02lu
> BogoMIPS).\n",
> +			bogosums / (500000/HZ), (bogosums / (5000/HZ)) %
> 100);
>  	} else
>  		bogosum[0] = '\0';
>
Ignore this change please.
