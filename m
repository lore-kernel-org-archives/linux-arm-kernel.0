From: eric.miao@linaro.org (Eric Miao)
Date: Tue, 6 Dec 2011 17:11:47 +0800
Subject: Error of 'handle_local_timer' missing in plat-mxc/gic.c when
 building 'mx5-merge' branch
In-Reply-To: <CAAQ0ZWSZJthOvw0EY3Of-Sn=n85H5VJSaFEZjgqGeUduKkLeZw@mail.gmail.com>
References: <CAMPhdO8ArDykEgXn6rdttPF3d6c_MUB4Bukh85VMNCYwg9Ezjw@mail.gmail.com>
 <CAAQ0ZWSZJthOvw0EY3Of-Sn=n85H5VJSaFEZjgqGeUduKkLeZw@mail.gmail.com>
Message-ID: <CAMPhdO-KyXDw-aR0NGSyQ_rzp5bpAjc=s-EttWz9qS+kK2s1Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 6, 2011 at 5:02 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On 6 December 2011 16:40, Eric Miao <eric.miao@linaro.org> wrote:
>> Hi Sascha,
>>
>> Just FYI,
>>
>> ?CC ? ? ?arch/arm/plat-mxc/gic.o
>> /home/ycmiao/linux-2.6/arch/arm/plat-mxc/gic.c: In function 'gic_handle_irq':
>> /home/ycmiao/linux-2.6/arch/arm/plat-mxc/gic.c:44:4: error: implicit
>> declaration of function 'handle_local_timer'
>> make[2]: *** [arch/arm/plat-mxc/gic.o] Error 1
>> make[1]: *** [arch/arm/plat-mxc] Error 2
>> make: *** [sub-make] Error 2
>>
>> Do we have a fix somewhere already?
>>
> This should be fixed by Marc's series below, which has hit the mainline.
>

Awesome. I'll do a quick merge and test if that's working.

Marc,

What's the status of the branch?


> Regards,
> Shawn
>
> -----
> Russell,
>
> I've collected patches converting GIC and VIC based platforms to use the
> MULTI_IRQ_HANDLER configuration option in a single branch (as they depend
> on a common patch).
>
> It also include the patch adding non-banked support to the GIC, which is
> required to convert EXYNOS to MULTI_IRQ_HANDLER in a sane way (not to
> mention fixing obvious bugs).
>
> If you're happy with this, feel free to pull this branch.
>
> Thanks,
>
> ? ? ? ?M.
>
> The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:
> ?Linus Torvalds (1):
> ? ? ? ?Linux 3.2-rc2
>
> are available in the git repository at:
>
> ?git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> irqchip-consolidation
>
> Jamie Iles (12):
> ? ? ?ARM: vic: device tree binding
> ? ? ?ARM: vic: MULTI_IRQ_HANDLER handler
> ? ? ?ARM: ep93xx: convert to MULTI_IRQ_HANDLER
> ? ? ?ARM: netx: convert to MULTI_IRQ_HANDLER
> ? ? ?ARM: nomadik: convert to MULTI_IRQ_HANDLER
> ? ? ?ARM: s3c64xx: convert to MULTI_IRQ_HANDLER
> ? ? ?ARM: spear: convert to MULTI_IRQ_HANDLER
> ? ? ?ARM: u300: convert to MULTI_IRQ_HANDLER
> ? ? ?ARM: versatile: convert to MULTI_IRQ_HANDLER
> ? ? ?ARM: samsung: convert to MULTI_IRQ_HANDLER
> ? ? ?ARM: picoxcell: convert to MULTI_IRQ_HANDLER
> ? ? ?ARM: VIC: remove non MULTI_IRQ_HANDLER support
>
> Marc Zyngier (19):
> ? ? ?ARM: gic: allow GIC to support non-banked setups
> ? ? ?ARM: Make global handler and CONFIG_MULTI_IRQ_HANDLER mutually exclusive
> ? ? ?ARM: mxc: rename gic_handle_irq to avoid name clash
> ? ? ?ARM: GIC: Add global gic_handle_irq() function
> ? ? ?ARM: imx: convert smp platforms to global gic_handle_irq()
> ? ? ?ARM: highbank: convert to CONFIG_MULTI_IRQ_HANDLER
> ? ? ?ARM: RealView: convert to CONFIG_MULTI_IRQ_HANDLER
> ? ? ?ARM: VExpress: convert to CONFIG_MULTI_IRQ_HANDLER
> ? ? ?ARM: msm: convert SMP platforms to CONFIG_MULTI_IRQ_HANDLER
> ? ? ?ARM: exynos4: convert to CONFIG_MULTI_IRQ_HANDLER
> ? ? ?ARM: tegra2: convert to CONFIG_MULTI_IRQ_HANDLER
> ? ? ?ARM: ux500: convert to CONFIG_MULTI_IRQ_HANDLER
> ? ? ?ARM: shmobile: convert smp platforms to gic_handle_irq()
> ? ? ?ARM: cns3xxx: convert to CONFIG_MULTI_IRQ_HANDLER
> ? ? ?ARM: zynq: convert to CONFIG_MULTI_IRQ_HANDLER
> ? ? ?ARM: omap2/3: Add global omap2/3_intc_handle_irq() functions
> ? ? ?ARM: omap2plus: convert to CONFIG_MULTI_IRQ_HANDLER
> ? ? ?ARM: omap2plus: remove irq-related global base addresses
> ? ? ?ARM: GIC: Make MULTI_IRQ_HANDLER mandatory
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
