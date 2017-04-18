From: dianders@chromium.org (Doug Anderson)
Date: Tue, 18 Apr 2017 13:08:44 -0700
Subject: usb: dwc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s
In-Reply-To: <79b9b35b-0600-771f-4cd2-9e03c5ba3a25@i2se.com>
References: <1795308650.27171.9a53158f-312d-40ce-80ce-8bf792d8db34.open-xchange@email.1und1.de>
 <172093673.40121.1492427140661@email.1und1.de>
 <CAD=FV=WJBTUcMPw8OgQT_jhz0H8AsH=YqWMR7LtudUKrF5-XOA@mail.gmail.com>
 <79b9b35b-0600-771f-4cd2-9e03c5ba3a25@i2se.com>
Message-ID: <CAD=FV=UB4KRvmrRKmRCTU3BoLV858bGPTQigWnvPYFxhHkEq4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 18, 2017 at 1:07 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> 1. With dwc2 you often end up in the situation where you need to
>> service an interrupt every 125 uS.  If servicing that interrupt takes
>> anywhere near 125 uS in the common case then you'll be in trouble.
>
> I will try to measure this with a logic analyzer.

Why a logic analyzer?  I'd think that "ftrace" would be your friend
here.  If you configure it just right you ought to be able to figure
out exactly what your kernel is doing.

...or, if you don't want to learn ftrace (it's cool and worth it, but
there's some time) you can just use "trace_printk" to get a fairly
low-over head printout to a memory buffer.  You can put that printout
in various places in the code and figure out what's taking so long.
In fact, that's exactly how the patch at
<https://chromium-review.googlesource.com/c/321980/4/drivers/usb/core/hcd.c>
works.

-Doug
