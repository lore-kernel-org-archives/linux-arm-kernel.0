From: vishwanath.bs@ti.com (Vishwanath Sripathy)
Date: Thu, 10 Mar 2011 14:36:55 +0530
Subject: [PATCH] OMAP4: Intialize IVA Device in addition to DSP device.
In-Reply-To: <1299738148-28557-1-git-send-email-shweta.gulati@ti.com>
References: <1299738148-28557-1-git-send-email-shweta.gulati@ti.com>
Message-ID: <fc1162b5d4e1a7deb77aa800a3e8fdb3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Shweta Gulati
> Sent: Thursday, March 10, 2011 11:52 AM
> To: linux-omap at vger.kernel.org
> Cc: Shweta Gulati; linux-arm-kernel at lists.infradead.org
> Subject: [PATCH] OMAP4: Intialize IVA Device in addition to DSP device.
>
> OMAP4 has two different Devices IVA and DSP. DSP is bound
> with MPU for DVFS and IVA has its own well defined OPPs.
DSP is not in MPU voltage domain. DSP(Tesla) and IVAHD are in the same
voltage domain. Pls correct this in the commit log.

Vishwa
> This Patch adds IVA init to 'omap2_init_processor_devices'
> and make sure that API 'omap2_set_init_voltage' is called
> for apt dev pointer.
>
> It fixes Error logs:
>
> 	omap2_set_init_voltage: Invalid parameters!
> 	omap2_set_init_voltage: Unable to put vdd_iva to its init voltage
>
> Tested on OMAP4430 SDP Board.
> Baseline:
> http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-
> pm.git
> Branch :pm-core
>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> ---
>  arch/arm/mach-omap2/pm.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 30af335..49486f5 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -89,6 +89,7 @@ static void omap2_init_processor_devices(void)
>  	if (cpu_is_omap44xx()) {
>  		_init_omap_device("l3_main_1", &l3_dev);
>  		_init_omap_device("dsp", &dsp_dev);
> +		_init_omap_device("iva", &iva_dev);
>  	} else {
>  		_init_omap_device("l3_main", &l3_dev);
>  	}
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
