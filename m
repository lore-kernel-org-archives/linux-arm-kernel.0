From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 May 2017 13:37:52 +0100
Subject: [PATCH 1/1] arm64: Always provide "model name" in /proc/cpuinfo
In-Reply-To: <20170502110827.GA29224@e104818-lin.cambridge.arm.com>
References: <20170501223913.6894-1-xypron.glpk@gmx.de>
 <20170502110827.GA29224@e104818-lin.cambridge.arm.com>
Message-ID: <20170502123752.GB28132@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 02, 2017 at 12:08:27PM +0100, Catalin Marinas wrote:
> On Tue, May 02, 2017 at 12:39:13AM +0200, Heinrich Schuchardt wrote:
> > There is no need to hide the model name in processes
> > that are not PER_LINUX32.
> > 
> > So let us always provide a model name that is easily readable.
> > 
> > Fixes: e47b020a323d ("arm64: Provide "model name" in /proc/cpuinfo for PER_LINUX32 tasks")
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >  arch/arm64/kernel/cpuinfo.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> > index b3d5b3e8fbcb..9ad9ddcd2f19 100644
> > --- a/arch/arm64/kernel/cpuinfo.c
> > +++ b/arch/arm64/kernel/cpuinfo.c
> > @@ -118,9 +118,8 @@ static int c_show(struct seq_file *m, void *v)
> >  		 * "processor".  Give glibc what it expects.
> >  		 */
> >  		seq_printf(m, "processor\t: %d\n", i);
> > -		if (compat)
> > -			seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
> > -				   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
> > +		seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
> > +			   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
> >  
> >  		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
> >  			   loops_per_jiffy / (500000UL/HZ),
> 
> Such patch seems to come up regularly:
> 
> https://patchwork.kernel.org/patch/9303311/
> 
> (and it usually gets rejected)

Indeed; my comments from that previous discussion apply here.

In addition, the commit message above refers to this as fixing another
commit, but does not explain why the current behviour would be
considered a bug.

I do not think it makes sense to take this patch.

Thanks,
Mark.
