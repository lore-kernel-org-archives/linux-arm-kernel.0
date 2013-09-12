From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 12 Sep 2013 13:01:35 +0200
Subject: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
In-Reply-To: <CAKohpomuJNQmk5fg5en5usPgipj7hzXUVNMhz1MjAS-47X4Ggg@mail.gmail.com>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
 <52310E43.1090808@intel.com>
 <CAKohpomuJNQmk5fg5en5usPgipj7hzXUVNMhz1MjAS-47X4Ggg@mail.gmail.com>
Message-ID: <3488595.xbBYlylYai@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 12, 2013 11:06:14 AM Viresh Kumar wrote:
> On 12 September 2013 06:13, Rafael J. Wysocki
> <rafael.j.wysocki@intel.com> wrote:
> > Yes, if you can point to a specific driver having this problem.
> 
> There are so many of those (I know it because I went through almost all drivers
> recently with my cleanup series): cpufreq-cpu0, omap-cpufreq,
> exynos-cpufreq, etc..
> 
> They all do this:
> 
> A. If new freq is more than old: Increase voltage
> B. Change freq
> C. If new freq is less than old: decrease voltage

Well, if there's more than one it's even simpler.  You can just pick one. :-)

Like, "for example, <driver name> does the following ... which may cause the
hardware to misbehave, because ...".

Thanks,
Rafael
