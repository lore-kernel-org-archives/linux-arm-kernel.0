From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Sun, 25 Sep 2016 09:29:19 +0900
Subject: [PATCH v2.1] arm64: kgdb: handle read-only text / modules
In-Reply-To: <20160923102340.GA2161@e104818-lin.cambridge.arm.com>
References: <20160923074208.9899-1-takahiro.akashi@linaro.org>
 <20160923094953.GC27704@e104818-lin.cambridge.arm.com>
 <20160923102340.GA2161@e104818-lin.cambridge.arm.com>
Message-ID: <20160925002917.GB4855@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Fri, Sep 23, 2016 at 11:23:40AM +0100, Catalin Marinas wrote:
> On Fri, Sep 23, 2016 at 10:49:53AM +0100, Catalin Marinas wrote:
> > On Fri, Sep 23, 2016 at 04:42:08PM +0900, AKASHI Takahiro wrote:
> > > Handle read-only cases (CONFIG_DEBUG_RODATA/CONFIG_DEBUG_SET_MODULE_RONX)
> > > by using aarch64_insn_write() instead of probe_kernel_write().
> > > See how this works:
> > >     commit 2f896d586610 ("arm64: use fixmap for text patching")
> > > 
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Jason Wessel <jason.wessel@windriver.com>
> > > Cc: <stable@vger.kernel.org> # 3.18-3.19: 2f896d5: arm64: use fixmap
> > > Cc: <stable@vger.kernel.org> # 3.18-3.19: f6242ca: arm64: Fix text
> > > Cc: <stable@vger.kernel.org> # 4.0-
> > 
> > Queued for 4.8 with a slight change in the last Cc: tag above:
> > 
> > Cc: <stable@vger.kernel.org> # 3.18.x-
> 
> I tried to apply this patch to 3.18, 4.1, 4.4, 4.7. It fails on all of
> them with smaller or slightly larger conflicts.

Oh, too bad.
I guest we'd better revert the following patches as well:
    c696b93 arm64/debug: Simplify BRK insn opcode declarations
    c172d99 arm64/debug: More consistent naming for the BRK ESR template macro
but I will check anyway.

> So, I'll merge it in 4.8 without any "Cc: stable" tags, just a "Fixes:"
> one for the commit introducing CONFIG_DEBUG_SET_MODULE_RONX (3.18). Once
> the patch reaches mainline, could you please back-port and test it on
> the stable kernel versions and send separate patches to
> stable at vger.kernel.org?

Thanks,
-Takahiro AKASHI

> Thanks.
> 
> -- 
> Catalin
