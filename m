From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 30 Nov 2011 22:50:24 +0800
Subject: [V3 2/6] RTC: sa1100: remove redundant code of setting alarm
In-Reply-To: <20111130135010.GB18533@game.jcrosoft.org>
References: <1322634629-4411-1-git-send-email-jtzhou@marvell.com>
 <20111130135010.GB18533@game.jcrosoft.org>
Message-ID: <CAN1soZzkcP=Xc_xh9bFmzFwGoviGOBaX46vT+xEwg7uAVuAhzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 9:50 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 14:30 Wed 30 Nov ? ? , Jett.Zhou wrote:
>> In rtc generic interface of setting alarm, it will check the alarm time
>> value valid or not, so rtc_periodic_alarm is redundant, remove it.
>>
>> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
>> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>> ---
>> ?drivers/rtc/rtc-sa1100.c | ? 53 ++++++++++-----------------------------------
>> ?1 files changed, 12 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
>> index 6f22c1f..d268cf1 100644
>> --- a/drivers/rtc/rtc-sa1100.c
>> +++ b/drivers/rtc/rtc-sa1100.c
>> @@ -45,16 +45,6 @@ static const unsigned long RTC_FREQ = 1024;
>> ?static struct rtc_time rtc_alarm;
>> ?static DEFINE_SPINLOCK(sa1100_rtc_lock);
>>
>> -static inline int rtc_periodic_alarm(struct rtc_time *tm)
>> -{
>> - ? ? return ?(tm->tm_year == -1) ||
>> - ? ? ? ? ? ? ((unsigned)tm->tm_mon >= 12) ||
>> - ? ? ? ? ? ? ((unsigned)(tm->tm_mday - 1) >= 31) ||
>> - ? ? ? ? ? ? ((unsigned)tm->tm_hour > 23) ||
>> - ? ? ? ? ? ? ((unsigned)tm->tm_min > 59) ||
>> - ? ? ? ? ? ? ((unsigned)tm->tm_sec > 59);
>> -}
>> -
>> ?/*
>> ? * Calculate the next alarm time given the requested alarm time mask
>> ? * and the current time.
>> @@ -82,27 +72,6 @@ static void rtc_next_alarm_time(struct rtc_time *next, struct rtc_time *now,
>> ? ? ? }
>> ?}
> please use read/write relaxed too
>
> Best Regards,
> J.

This will be replaced with read/write in the third patch.
