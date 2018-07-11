From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jul 2018 10:46:39 +0100
Subject: [PATCHv4 11/19] arm64: don't reload GPRs after apply_ssbd
In-Reply-To: <20180710173317.GC10177@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
 <20180702110415.10465-12-mark.rutland@arm.com>
 <20180706163844.GB27483@arm.com>
 <20180709142159.tsxgwhjm3qziymym@lakrids.cambridge.arm.com>
 <20180710103722.GH9486@e103592.cambridge.arm.com>
 <20180710173317.GC10177@arm.com>
Message-ID: <20180711094639.abltbull7adjzcit@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 06:33:18PM +0100, Will Deacon wrote:
> On Tue, Jul 10, 2018 at 11:37:24AM +0100, Dave Martin wrote:
> > For the kernel, I suggest using a .L prefix so that the generated
> > symbols don't bloat the vmlinux symbol table (similar to numbered local
> > labels) -- unless you really want the symbols retained.
> > 
> > Having a common prefix for all "unique" assembler symbols may help us
> > to avoid namespace collisions, say
> > 
> > .L__asm__foo_\@
> > .L__asm__bar_\@
> 
> Hmm, yes, and that would allow us to replace the open-coded labels in
> our assembler.h macros as well, wouldn't it?

Yup.

For this patch, I'll rename skip_apply_ssbd\@ to .L__asm_ssbd_skip\@.

I'll send another patch (or series) converting our other macros to this
scheme. We can either take that with this series, or as subsequent
cleanup.

Thanks,
Mark.
