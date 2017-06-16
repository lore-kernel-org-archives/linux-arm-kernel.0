From: shuah@kernel.org (Shuah Khan)
Date: Fri, 16 Jun 2017 09:19:06 -0600
Subject: [PATCH 0/3] rtc: make st-lpc robust against y2038/2106 bug
In-Reply-To: <1497621833-9942-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497621833-9942-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <fe91e845-7218-af8a-16ec-f4c0692e609f@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2017 08:03 AM, Benjamin Gaignard wrote:
> On 32bits platforms "struct timeval" or "time_t" are using u32 to code the
> date, this cause tools like "date" or "hwclock" failed even before setting
> the RTC device if the date is superior to year 2038 (or 2106).
> 
> To avoid this problem I add two RTC tests files which directly use RTC ioctl
> to set and read RTC time and alarm values.
> rtctest_setdate allow to set any date/time given in the command line.
> rtctest-2038 perform a basic test by writing 1-1-2200 in RTC time and alarm
> and checking that the read back values are correct.
> 
> Finally that had allowed me to test and fix rtc-st-lpc driver.
> 
> Benjamin Gaignard (3):
>   tools: timer: add rtctest_setdate
>   tools: timer: add test to check y2038/2106 bug
>   rtc: st-lpc: make it robust against y2038/2106 bug
> 
>  drivers/rtc/rtc-st-lpc.c                         |  19 ++--
>  tools/testing/selftests/timers/Makefile          |   4 +-
>  tools/testing/selftests/timers/rtctest-2038.c    | 135 +++++++++++++++++++++++
>  tools/testing/selftests/timers/rtctest_setdate.c |  86 +++++++++++++++
>  4 files changed, 232 insertions(+), 12 deletions(-)
>  create mode 100644 tools/testing/selftests/timers/rtctest-2038.c
>  create mode 100644 tools/testing/selftests/timers/rtctest_setdate.c
> 

Hi John/Thomas,

Please review them and let me know. Looks to me these will make good
additions to 4.13-rc1 kselftest content.

thanks,
-- Shuah
