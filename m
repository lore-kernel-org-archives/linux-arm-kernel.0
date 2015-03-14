From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 14 Mar 2015 11:41:09 +0000
Subject: [PATCH 4/6] ARM64: cpuidle: Rename cpu_init_idle to a common
 function name
In-Reply-To: <20150313182246.GT30671@e104818-lin.cambridge.arm.com>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
 <1425385777-14766-5-git-send-email-daniel.lezcano@linaro.org>
 <20150313182246.GT30671@e104818-lin.cambridge.arm.com>
Message-ID: <20150314114109.GB9696@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 06:22:46PM +0000, Catalin Marinas wrote:
> On Tue, Mar 03, 2015 at 01:29:35PM +0100, Daniel Lezcano wrote:
> > diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> > index 0cea244..6ef291c7 100644
> > --- a/drivers/cpuidle/cpuidle-arm64.c
> > +++ b/drivers/cpuidle/cpuidle-arm64.c
> > @@ -110,7 +110,7 @@ static int __init arm64_idle_init(void)
> >  	 * idle states suspend back-end specific data
> >  	 */
> >  	for_each_possible_cpu(cpu) {
> > -		ret = cpu_init_idle(cpu);
> > +		ret = arm_cpuidle_init(cpu);
> 
> Same nitpick here about dropping the arm_ prefix (though here we already
> have a cpuidle_init).

Actually, a question, probably for Lorenzo - why do we need to call
cpu_init_idle() from the driver? Is there any dependency on what the
driver had done before this call? If not, I suggest a core_initcall() in
the arch code for cpu_init_idle(). At a quick look through the code, the
back-end can be initialised on its own.

-- 
Catalin
