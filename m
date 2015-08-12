From: Dongsheng.Wang@freescale.com (Wang Dongsheng)
Date: Wed, 12 Aug 2015 08:01:32 +0000
Subject: [PATCH v2 1/2] soc/fsl: add freescale dir for SOC specific drivers
In-Reply-To: <20150812074439.GF7557@n2100.arm.linux.org.uk>
References: <1439358807-9024-1-git-send-email-dongsheng.wang@freescale.com>
 <20150812074439.GF7557@n2100.arm.linux.org.uk>
Message-ID: <SN1PR0301MB1616C942574FB3261B811DB19D7E0@SN1PR0301MB1616.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks for your review. :)

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Wednesday, August 12, 2015 3:45 PM
> To: Wang Dongsheng-B40534
> Cc: shawn.guo at linaro.org; Wang Huan-B18965; linus.walleij at linaro.org; linux-
> kernel at vger.kernel.org; sandeep_n at ti.com; hdegoede at redhat.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2 1/2] soc/fsl: add freescale dir for SOC specific drivers
> 
> On Wed, Aug 12, 2015 at 01:53:26PM +0800, Dongsheng Wang wrote:
> > diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig new
> > file mode 100644 index 0000000..863d1ef
> > --- /dev/null
> > +++ b/drivers/soc/fsl/Kconfig
> > @@ -0,0 +1,18 @@
> > +#
> > +# Freescale SOC drivers
> > +#
> > +menuconfig FSL_SOC_DRIVERS
> > +	bool "Freescale Soc Drivers"
> > +	default n
> 
> No need for default n.

Thanks. Fix it in next version.

> > +	help
> > +	Say y here to enable Freescale LS1021A Soc Device Drivers support.
> > +	The Soc Drivers provides the device driver that is a specific block
> > +	or feature on LS1021A platform.
> 
> Help text should be indented by two spaces as per almost every other help text.
> 

Thanks. My mistake...

> > +
> > +if LS1_SOC_DRIVERS
> > +	source "drivers/soc/fsl/ls1/Kconfig"
> > +endif
> > diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile new
> > file mode 100644 index 0000000..b4215dd
> > --- /dev/null
> > +++ b/drivers/soc/fsl/Makefile
> > @@ -0,0 +1,6 @@
> > +#
> > +# Makefile for Freescale Soc specific device drivers.
> > +#
> > +
> > +obj-$(CONFIG_LS1_SOC_DRIVERS) += ls1/
> > +
> > diff --git a/drivers/soc/fsl/ls1/Kconfig b/drivers/soc/fsl/ls1/Kconfig
> > new file mode 100644 index 0000000..7556f44
> > --- /dev/null
> > +++ b/drivers/soc/fsl/ls1/Kconfig
> > @@ -0,0 +1,3 @@
> > +#
> > +# LS-1 Soc drivers
> > +#
> 
> Doesn't this directory need a Makefile as well?
> 

2/2 patch add a config option and Makefile for this.

Regards,
-Dongsheng
