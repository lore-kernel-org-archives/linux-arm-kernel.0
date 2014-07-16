From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 16 Jul 2014 16:02:56 +0200
Subject: [PATCH 2/8] cpufreq: add driver for Armada XP
In-Reply-To: <CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
Message-ID: <20140716160256.7e8dbccf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Viresh Kumar,

On Fri, 4 Jul 2014 15:25:35 +0530, Viresh Kumar wrote:
> On 4 July 2014 15:14, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > This commit adds a simple cpufreq driver for the Armada XP SoC, which
> > has one separately controllable clock for each CPU. For this reason,
> > the existing cpufreq-cpu0 generic driver cannot be used because it
> > currently assumes that there is only one clock controlling the
> > frequency of all CPUs.
> >
> > There are on-going discussions on extending the cpufreq-cpu0 to cover
> > the case of having one clock for each CPU, but there are still some
> > unresolved issues to get this extended cpufreq-cpu0 driver merged.
> 
> Exactly, and those changes would get merged in one form or the other.
> Surely in 3.17 atleast, if not 3.16 as we are already reaching rc4..
> 
> So, it would be great if you can test on top of those changes to see if
> something isn't solved for your platform yet?
> 
> git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/cpu0-krait-v3

Are these changes in linux-next ? The mvebu maintainer Jason Cooper has
pulled the cpufreq support for Armada XP, so it will appear in
linux-next tomorrow. It would be good of the cpufreq-generic driver
improvements (to support one clock per CPU) were also part of
linux-next so that we could test that the combination works as expected
(of course, I did test locally, but I'd like to ensure it still works
in linux-next).

Could you get your tree in linux-next, or get your patches merged by
Rafael in his linux-next branch so that they will appear in linux-next ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
