From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 24 Jun 2017 00:09:07 +0200
Subject: [PATCH v2 0/3] rtc: make st-lpc robust against y2038/2106 bug
In-Reply-To: <47b45b70-91da-ce41-535d-89d92f380274@kernel.org>
References: <1497864982-29284-1-git-send-email-benjamin.gaignard@linaro.org>
 <47b45b70-91da-ce41-535d-89d92f380274@kernel.org>
Message-ID: <20170623220907.kxhkwkl6gt7bho5r@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/06/2017 at 13:40:41 -0600, Shuah Khan wrote:
> On 06/19/2017 03:36 AM, Benjamin Gaignard wrote:
> > On 32bits platforms "struct timeval" or "time_t" are using u32 to code the
> > date, this cause tools like "date" or "hwclock" failed even before setting
> > the RTC device if the date is superior to year 2038 (or 2106).
> > 
> > To avoid this problem I add one RTC test file which directly use RTC ioctl
> > to set and read RTC time and alarm values.
> > rtctest_setdate allow to set any date/time given in the command line.
> > 
> > On this version 2 I add check of problematics years in rtctest like suggest
> > by Alexandre.
> > 
> > Finally that had allowed me to test and fix rtc-st-lpc driver.
> > 
> > Benjamin Gaignard (3):
> >   tools: timer: add rtctest_setdate
> >   tool: timer: rtctest add check for problematic dates
> >   rtc: st-lpc: make it robust against y2038/2106 bug
> > 
> >  drivers/rtc/rtc-st-lpc.c                         |  19 ++--
> >  tools/testing/selftests/timers/Makefile          |   2 +-
> >  tools/testing/selftests/timers/rtctest.c         | 121 ++++++++++++++++++++++-
> >  tools/testing/selftests/timers/rtctest_setdate.c |  86 ++++++++++++++++
> >  4 files changed, 212 insertions(+), 16 deletions(-)
> >  create mode 100644 tools/testing/selftests/timers/rtctest_setdate.c
> > 
> 
> Hi Thomas/John,
> 
> I can take the first two patches in this series through linux-kselftest
> with your or John's Ack. Please review and let me know one way or the
> other.
> 

Well, I'm the maintainer for rtctest.c and I'll make sure to also be the
one for rtctest_setdate.c.

> The third one is a rtc driver patch. Please let me know how do you want
> to handle this series soon we can get this into 4.13-rc1.
> 

I'll take the three patches but I still have comment I didn't have time
to give yet.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
