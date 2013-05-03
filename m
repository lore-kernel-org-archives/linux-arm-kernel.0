From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 3 May 2013 18:31:52 +0530
Subject: [PATCH,
 RFC 02/22] cpufreq: ARM_DT_BL_CPUFREQ needs ARM_CPU_TOPOLOGY
In-Reply-To: <5563691.6kxbXZTjH5@vostro.rjw.lan>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-3-git-send-email-arnd@arndb.de>
 <CAKohpomBKuaxk+sSF63cu6JKut1uV7J7Sj2o85c3wQ=fodx+Ow@mail.gmail.com>
 <5563691.6kxbXZTjH5@vostro.rjw.lan>
Message-ID: <CAKohpon9qmowJ4PmL-nvnoaCzJSC-ZSPv8EUOyoFcTdRqNRwnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 May 2013 17:45, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> In this particular case I think it is OK to make both ARM_DT_BL_CPUFREQ and
> ARM_BIG_LITTLE_CPUFREQ depend on ARM_CPU_TOPOLOGY, because (in theory?) the
> latter may be set without the former (unless you want to make ARM_DT_BL_CPUFREQ
> depend on ARM_BIG_LITTLE_CPUFREQ, but then it may be kind of confusing to
> users).

ARM_BIG_LITTLE_CPUFREQ is the core cpufreq code for big LITTLE SoC's and every
other driver will be a glue providing ops to it. So, ARM_DT_BL_CPUFREQ
does depend
on ARM_BIG_LITTLE_CPUFREQ and that's why i added depends on
ARM_CPU_TOPOLOGY in ARM_BIG_LITTLE_CPUFREQ only and depends on
ARM_BIG_LITTLE_CPUFREQ in ARM_DT_BL_CPUFREQ.

But the problem is if ARM_DT_BL_CPUFREQ isn't selected then we still get
ARM_DT_BL_CPUFREQ enabled in menuconfig but a warning just before compilation.
Which Arnd pointed to..
