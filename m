From: burman.yan@gmail.com (Yan Burman)
Date: Thu, 9 Aug 2012 11:54:40 +0300
Subject: [PATCH] ARM: ep93xx: clockevent support
In-Reply-To: <5021122C.3000503@gmail.com>
References: <1344338474.18237.6.camel@localhost> <5021122C.3000503@gmail.com>
Message-ID: <CANapsLQ6kCUN5UoaA3xejm24SGxCKmZEFgmR_+r7N-=DPz0TVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/7/12, Ryan Mallon <rmallon@gmail.com> wrote:
> On 07/08/12 21:21, Yan Burman wrote:
>
>> ARM: ep93xx: clockevent support
>> I have ported to 3.6-rc1 and slightly modified a previous patch for
>> clockevent support for the ep93xx.
>> The porting mainly consists of sched_clock support.
>> Tested on 9302 based board.
>> From: Ahmed Ammar <aammar <at> edge-techno.com>
>> Signed-off-by: Yan Burman <burman.yan@gmail.com>
>
>
> Hi Yan, some comments below.
>
> ~Ryan
>
>> +	case CLOCK_EVT_MODE_ONESHOT:
>> +		tmode |= EP93XX_TIMER123_CONTROL_ENABLE;
>> +		__raw_writel(tmode, EP93XX_TIMER1_CONTROL);
>> +		break;
>> +
>> +	case CLOCK_EVT_MODE_SHUTDOWN:
>> +	case CLOCK_EVT_MODE_UNUSED:
>> +	case CLOCK_EVT_MODE_RESUME:
>> +		return;
>
>
> These cases can be removed.
>

This case is something that is present in most (if not all) other architectures.
I don't mind removing it, but it will have to be replaced with:
default:
     ;

Since GCC produces warnings otherwise.

Other than that I am going to wait a while more for more comments if
somebody has them,
and post a new version with style fixes as well as switch to
drivers/clocksource/mmio.c usage.

Regards,
Yan
