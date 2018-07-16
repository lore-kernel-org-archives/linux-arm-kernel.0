From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Jul 2018 12:11:53 +0200
Subject: [PATCH] [RFC] y2038: globally rename compat_time to old_time32
In-Reply-To: <CABeXuvphoYM+KOGPgtsuxzS1_XDSOO0Ta5hr3sA7gYtt-78wtQ@mail.gmail.com>
References: <20180713133204.3123939-1-arnd@arndb.de>
 <CABeXuvphoYM+KOGPgtsuxzS1_XDSOO0Ta5hr3sA7gYtt-78wtQ@mail.gmail.com>
Message-ID: <CAK8P3a2xu4KGVM1BvTjtXKHfXpBQ2PMynAPybW4cRt7FB8ktwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 14, 2018 at 5:54 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> Right now we only have compat syscalls and native syscalls.
> Until we transition all the architectures to use the new syscalls,
> wouldn't it be the same sort of confusion as exists today?
> These structures today are still used by compat entry points.
> I'm trying to understand why such a cleanup would make sense today
> rather than at the end of the transition.

I don't think it makes a big difference whether we change it now or later,
but if Christoph feels that it addresses his concern about the compat_
namespace being reused during the transition, doing it earlier would
enable us to finish the remaining syscalls.

We are running a little late with the remaining syscalls for 4.19 as we
now have an rc5. At this point we probably won't have time to finish
the discussion about all of clock_adjtime, getrusage/waitid and getitimer(),
but I'd really like to get utimensat, futex, sched_rr_get_interval,
recvmmsg, sys_io_getevents, rt_sigtimedwait, ppoll and pselect6
done for 4.19 so we can finalize the ABI for 4.20 along with doing
the actual conversion.

      Arnd
