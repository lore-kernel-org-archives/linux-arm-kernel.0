From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 28 Feb 2011 15:23:33 +0800
Subject: [PATCH v2 1/1] ARM: imx53: correct Silicon Revision definition
	following fuse map
In-Reply-To: <AANLkTikC-bMK=7CcbyEZWvab=Qe19TJBGWGC6tmN5gnd@mail.gmail.com>
References: <1298031990-4521-1-git-send-email-richard.zhao@freescale.com>
	<AANLkTikC-bMK=7CcbyEZWvab=Qe19TJBGWGC6tmN5gnd@mail.gmail.com>
Message-ID: <20110228072332.GA2431@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Could you please merge this patch?

Thanks
Richard
On Tue, Feb 22, 2011 at 03:46:31PM +0800, Jason Chen wrote:
> 2011/2/18 Richard Zhao <richard.zhao@freescale.com>:
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> Acked-by: Jason Chen <jason.chen@freescale.com>
> >
> > diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
> > index d40671d..df46b5e 100644
> > --- a/arch/arm/mach-mx5/cpu.c
> > +++ b/arch/arm/mach-mx5/cpu.c
> > @@ -78,11 +78,16 @@ static int get_mx53_srev(void)
> > ? ? ? ?void __iomem *iim_base = MX51_IO_ADDRESS(MX53_IIM_BASE_ADDR);
> > ? ? ? ?u32 rev = readl(iim_base + IIM_SREV) & 0xff;
> >
> > - ? ? ? if (rev == 0x0)
> > + ? ? ? switch (rev) {
> > + ? ? ? case 0x0:
> > ? ? ? ? ? ? ? ?return IMX_CHIP_REVISION_1_0;
> > - ? ? ? else if (rev == 0x10)
> > + ? ? ? case 0x2:
> > ? ? ? ? ? ? ? ?return IMX_CHIP_REVISION_2_0;
> > - ? ? ? return 0;
> > + ? ? ? case 0x3:
> > + ? ? ? ? ? ? ? return IMX_CHIP_REVISION_2_1;
> > + ? ? ? default:
> > + ? ? ? ? ? ? ? return IMX_CHIP_REVISION_UNKNOWN;
> > + ? ? ? }
> > ?}
> >
> > ?/*
> > --
> > 1.7.1
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
