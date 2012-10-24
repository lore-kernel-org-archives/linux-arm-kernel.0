From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 25 Oct 2012 00:02:17 +0200
Subject: [PATCH 1/2] cpufreq: return early from __cpufreq_driver_getavg()
In-Reply-To: <CAKohponGwhC_zmk1Whq56vmZMvjcxXKiSpdvMk4ZU8z0Wa2TBw@mail.gmail.com>
References: <32e5bed743cc6cc4e614291a7080299f5f0d0933.1350677395.git.viresh.kumar@linaro.org>
 <2737823.2JYE7UmLRN@vostro.rjw.lan>
 <CAKohponGwhC_zmk1Whq56vmZMvjcxXKiSpdvMk4ZU8z0Wa2TBw@mail.gmail.com>
Message-ID: <112621141.CGPLIkkgz1@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 of October 2012 10:12:07 Viresh Kumar wrote:
> On Oct 20, 2012 3:37 AM, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > On Saturday 20 of October 2012 01:42:05 Viresh Kumar wrote:
> > > There is no need to do cpufreq_get_cpu() and cpufreq_put_cpu() for
> drivers that
> > > don't support getavg() routine.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > The patch doesn't seem to follow the changelog or the other way around.
> 
> Sorry if my log isn't clear enough.
> But i could still see it matching the code :)
> 
> I have moved the check for drivers capabilities at the top
> of routine, so that there is no need to call mentioned routines.

OK

Applied to linux-pm.git/linux-next as v3.8 material.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
