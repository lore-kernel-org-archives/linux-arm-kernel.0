From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Apr 2015 18:31:10 +0100
Subject: [PATCH v5 07/11] ARM: imx: add msl support for imx7d
In-Reply-To: <1429628007-8892-8-git-send-email-Frank.Li@freescale.com>
References: <1429628007-8892-1-git-send-email-Frank.Li@freescale.com>
 <1429628007-8892-8-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150421173110.GG10164@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static void __init imx_ca7_smp_init_cpus(void)
> +{
> +       int i, ncores;
> +       unsigned long val;
> +
> +       asm volatile("mrc p15, 1, %0, c9, c0, 2" : "=r" (val));
> +       ncores = ((val >> 24) & 0x3) + 1;
> +       if (setup_max_cpus < ncores)
> +               ncores = (setup_max_cpus) ? setup_max_cpus : 1;
> +
> +       for (i = ncores; i < NR_CPUS; i++)
> +               set_cpu_possible(i, false);
> +}

NAK.

The set of available CPUs should come from the DT, as with other
platforms.

Mark.
