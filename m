From: will.deacon@arm.com (Will Deacon)
Date: Thu, 18 May 2017 16:13:30 +0100
Subject: [PATCH] arm64: cpufeature: check translation granule size based
 on kernel config
In-Reply-To: <20170518142415.GA6425@leverpostej>
References: <1495102873-10858-1-git-send-email-leo.yan@linaro.org>
 <c0c8bd7b-647d-092d-65ac-08a90000e30c@arm.com>
 <20170518113627.GC25294@leoy-ThinkPad-T440>
 <20170518123840.GD21359@arm.com>
 <20170518124115.GC4957@leverpostej>
 <20170518130250.GE25294@leoy-ThinkPad-T440>
 <20170518142415.GA6425@leverpostej>
Message-ID: <20170518151329.GF21359@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 03:24:15PM +0100, Mark Rutland wrote:
> On Thu, May 18, 2017 at 09:02:50PM +0800, Leo Yan wrote:
> > On Thu, May 18, 2017 at 01:41:15PM +0100, Mark Rutland wrote:
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index 94b8f7f..1f53314 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -639,8 +639,8 @@ void update_cpu_features(int cpu,
> > >          * Mismatched CPU features are a recipe for disaster. Don't even
> > >          * pretend to support them.
> > >          */
> > > -       WARN_TAINT_ONCE(taint, TAINT_CPU_OUT_OF_SPEC,
> > > -                       "Unsupported CPU feature variation.\n");
> > > +       pr_warn_once("Unsupported CPU feature variation detected.\n");
> > > +       add_taint(TAINT_CPU_OUT_OF_SPEC);
> > 
> > Should be add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK)?
> 
> Whoops; yes.

I've picked this up with the fix above.

Will
