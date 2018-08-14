From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 14 Aug 2018 10:15:56 -0600
Subject: [PATCH v3 0/7] perf: Add ioctl for PMU driver configuration
In-Reply-To: <20180813124642.3d49c082a95fc294d926016e@arm.com>
References: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
 <20180813124642.3d49c082a95fc294d926016e@arm.com>
Message-ID: <CANLsYkx=tjCG-eb4qRoGz0SvG4qCMDz1ajR9Mo9VK5XTAn_WdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Aug 2018 at 11:46, Kim Phillips <kim.phillips@arm.com> wrote:
>
> On Wed, 18 Jul 2018 15:48:00 -0600
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> > This set adds the capability to communiate event specific configuration
> > to the PMU kernel driver using an ioctl().  The functionatlity is made
> > generic enough for anyone to use but is targeted at the identification
> > of CoreSight sinks when operating in CPU-wide trace scenarios.
> >
> > ---
> > Changes for V3:
> > . Return an error for CPU-wide scenarios while the feature is being
> >   implemented (Kim)
>
> Hi, I'm giving this series a short test-drive on Juno.

Hi,

>
> It yields success for the --per-thread case..:
>
> $ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ --per-thread uname -a
> Linux juno 4.18.0-rc8-00011-gb82af52c4b35-dirty #147 SMP PREEMPT Thu Aug 9 11:20:37 CDT 2018 aarch64 GNU/Linux
> [ perf record: Woken up 0 times to write data ]
> Warning:
> AUX data lost 1 times out of 2!
>
> [ perf record: Captured and wrote 0.067 MB perf.data ]
> $
>
> ..but not for CPU-wide?:
>
> $ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ uname -a
> failed to mmap with 12 (Cannot allocate memory)
> $ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ -C 0 uname -a
> failed to mmap with 12 (Cannot allocate memory)
> $

This patchset is getting very old and a fair amount of things have
changed since then.  I'm hoping to be coming out with a new one
shortly.  Nonetheless the above is returning an error in CPU-wide
scenarios while the feature is being implemented.  Isn't what you
requested or have I misunderstood your comment?

>
> Thanks,
>
> Kim
