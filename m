From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 12 Nov 2012 11:11:20 +0100
Subject: [PATCH v3 6/6] ARM: EXYNOS: Add secure firmware support to
 secondary CPU bring-up
In-Reply-To: <20121112095231.GE28327@n2100.arm.linux.org.uk>
References: <1351178560-19188-1-git-send-email-t.figa@samsung.com>
 <1351178560-19188-7-git-send-email-t.figa@samsung.com>
 <20121112095231.GE28327@n2100.arm.linux.org.uk>
Message-ID: <2714070.uUa63CRanW@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 of November 2012 09:52:31 Russell King - ARM Linux wrote:
> On Thu, Oct 25, 2012 at 05:22:40PM +0200, Tomasz Figa wrote:
> > @@ -47,6 +48,8 @@ static inline void __iomem *cpu_boot_reg(int cpu)
> > 
> >  {
> >  
> >  	void __iomem *boot_reg;
> > 
> > +	if (!call_firmware_op(cpu_boot_reg, cpu, &boot_reg))
> > +		return boot_reg;
> > 
> >  	boot_reg = cpu_boot_reg_base();
> 
> That code makes no sense.

Why?

call_firmware_op returning 0 means a success, so boot_reg is filled with 
proper boot register address, which should be used.

Otherwise (call_firmware_op returning an error) the legacy boot register 
is used.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
