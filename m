From: john.stultz@linaro.org (John Stultz)
Date: Wed, 21 Aug 2013 13:39:28 -0700
Subject: [PATCHv2 2/2] clocksource: dw_apb_timer_of: Fix read_sched_clock
In-Reply-To: <1377115342.1554.21.camel@linux-builds1>
References: <1376522956-14960-1-git-send-email-dinguyen@altera.com>
 <1376522956-14960-2-git-send-email-dinguyen@altera.com>
 <CACRpkda9oyb2mr6PR1dfMpoxbzj3vUp7hKiQtN1oWH6aG_N96w@mail.gmail.com>
 <20130821190729.GA9657@amd.pavel.ucw.cz>
 <1377115342.1554.21.camel@linux-builds1>
Message-ID: <52152580.90508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2013 01:02 PM, Dinh Nguyen wrote:
> On Wed, 2013-08-21 at 21:07 +0200, ZY - pavel wrote:
>> On Wed 2013-08-21 09:04:07, Linus Walleij wrote:
>>> On Thu, Aug 15, 2013 at 1:29 AM,  <dinguyen@altera.com> wrote:
>>>
>>>> -       sched_io_base = iobase + 0x04;
>>>> +       sched_io_base = iobase;
>>>>         sched_rate = rate;
>>>>  }
>>>>
>>>>  static u32 read_sched_clock(void)
>>>>  {
>>>> -       return __raw_readl(sched_io_base);
>>>> +       return ~__raw_readl(sched_io_base + 0x4);
>>> So what about #define what 0x04 is?
>>>
>>> #define MY_FOO_REGISTER_OFFSET 0x04
>>>
>>> raw_readl(sched_io_base + MY_FOO_REGISTER_OFFSET);
>> That define is already there, #define APBTMR_N_CURRENT_VALUE 0x04, but
>> it is in .c file, not in header.
> I'll send a V2 that will address this comment and Stephen Warren's.
Please be sure to CC Daniel Lezcano <daniel.lezcano@linaro.org> on
future versions as he's now maintaining the drivers/clocksource directory.

thanks
-john
