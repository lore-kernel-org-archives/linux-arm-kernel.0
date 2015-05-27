From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Wed, 27 May 2015 18:37:27 +0530
Subject: [PATCH v4 2/2] soc: Add driver for Freescale Vybrid Platform
In-Reply-To: <1432711910.27695.223.camel@x220>
References: <cover.1432637313.git.maitysanchayan@gmail.com>
 <7df753efff77a96da285f0571f1316512787e83c.1432637313.git.maitysanchayan@gmail.com>
 <1432711910.27695.223.camel@x220>
Message-ID: <20150527130727.GA3374@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 15-05-27 09:31:50, Paul Bolle wrote:
> On Tue, 2015-05-26 at 17:06 +0530, Sanchayan Maity wrote:
> > --- /dev/null
> > +++ b/drivers/soc/fsl/Kconfig
> 
> > +config SOC_VF610
> > +	   bool "SoC bus device for the Freescale Vybrid platform"
> > +	   select SOC_BUS
> > +	   help
> > +	     Include support for the SoC bus on the Freescale Vybrid platform
> > +	     providing some sysfs information about the module variant.
> > \ No newline at end of file
> 
> (That review comment is courtesy of git.)

Will fix it.

> 
> > --- /dev/null
> > +++ b/drivers/soc/fsl/Makefile
> 
> > +obj-$(CONFIG_SOC_VF610)		+= soc-vf610.o
> 
> > --- /dev/null
> > +++ b/drivers/soc/fsl/soc-vf610.c
> 
> > +MODULE_DEVICE_TABLE(of, vf610_soc_bus_match);
> 
> > +module_platform_driver(vf610_soc_driver);
> 
> (The series starting at https://lkml.org/lkml/2015/5/10/131 would allow
> to use builtin_platform_driver() for built-in only code.)

Thanks for bringing this to my attention. I am subscribed to the mailing
list however this skipped me.

> 
> > +MODULE_DESCRIPTION("Freescale VF610 SoC bus driver");
> > +MODULE_LICENSE("GPL v2");
> 
> I think soc-vf610.o can only be built-in. But its code contains a few
> module specific macros. Was it perhaps intended for SOC_VF610 to be
> tristate?

I too think that should be built-in. Did not have an intention of making
it tristate, however while using other drivers as references, the perhaps
unneccessary stuff crept in.

The MODULE_* references can be removed along with the corresponding header
file. However that series has not been merged yet, so I can't use builtin_*
yet?

@Arnd

Are you ok with the patch in general? I can take care of the above changes
and send a new version. And once the builtin_driver stuff gets merged, I
can send a minor patch to change this module one to builtin?

Regards,
Sanchayan.
