From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 22 Apr 2014 11:05:20 -0600
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <535639EE.7040102@linaro.org>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <534EF153.5050603@codeaurora.org>
 <alpine.LFD.2.11.1404161853530.980@knanqh.ubzr>
 <53501E87.6070307@codeaurora.org>
 <20140417203521.GB22411@obsidianresearch.com>
 <535639EE.7040102@linaro.org>
Message-ID: <20140422170520.GB23955@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 10:44:14AM +0100, Daniel Thompson wrote:
> On 17/04/14 21:35, Jason Gunthorpe wrote:
> >>> The above is useful for loading the raw uncompressed Image without 
> >>> carrying the full ELF baggage.
> >>
> >> What exactly is the full ELF baggage? Aren't there existing mechanisms to omit
> >> debugging symbols, for example, if size is of concern?
> > 
> > FWIW, it is a small non-intrusive change to produce ELFs with the
> > proper LMA, if it is useful for specialized tooling, here is the 3.14
> > version of the patch I created (I see it needs a bit of cleanup..)
> > You must also force PATCH_PHYS_VIRT off.
> > 
> > The ELF also has the correct entry point address, so ELF tooling can
> > just jump into it, after setting the proper register values according
> > to the boot protocol.
> 
> That might be a useful approach for single platform kernels but I don't
> think such an approach can work for multi-arch kernels since, because
> the RAM can be located anywhere in the address map, the physical load
> address is platform dependant.

Right, I think everyone realizes that.

What this patch does is make kernels that are built with
PLAT_PHYS_OFFSET set and CONFIG_ARM_PATCH_PHYS_VIRT disabled produce
an ELF that reflects the build configuration.

Based on comments from others in the thread this is looking useful for
a variety of cases.

I'm not sure who would need to ack this patch? I can clean it up of course.

Thanks,
Jason
