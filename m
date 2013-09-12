From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 12 Sep 2013 11:06:14 +0530
Subject: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
In-Reply-To: <52310E43.1090808@intel.com>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
 <2703632.ul5ekQh5oq@vostro.rjw.lan>
 <CAKohpo=RKB-_EO=cjaOorAfN=y_cMgJg-j6=xtX71a-TwujgsA@mail.gmail.com>
 <2013615.oHjWkmedue@vostro.rjw.lan>
 <CAKohpokEZcwF-zL6rTXYyC_x=SJzGFvdvxqvmvyhJHa8nPXogQ@mail.gmail.com>
 <52310E43.1090808@intel.com>
Message-ID: <CAKohpomuJNQmk5fg5en5usPgipj7hzXUVNMhz1MjAS-47X4Ggg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 September 2013 06:13, Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
> Yes, if you can point to a specific driver having this problem.

There are so many of those (I know it because I went through almost all drivers
recently with my cleanup series): cpufreq-cpu0, omap-cpufreq,
exynos-cpufreq, etc..

They all do this:

A. If new freq is more than old: Increase voltage
B. Change freq
C. If new freq is less than old: decrease voltage
