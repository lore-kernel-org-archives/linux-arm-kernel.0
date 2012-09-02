From: gerg@snapgear.com (Greg Ungerer)
Date: Sun, 2 Sep 2012 21:45:32 +1000
Subject: [PATCH 4/4] ARM: ks8695: convert to generic time and clocksource
In-Reply-To: <CACRpkdZ0Gw5H_yRcN2CmC+F8NtUcySTrLehuzZdWrbDwL4HHWw@mail.gmail.com>
References: <1346264842-20411-1-git-send-email-linus.walleij@linaro.org>
 <504057A8.7030302@snapgear.com>
 <CACRpkdZ0Gw5H_yRcN2CmC+F8NtUcySTrLehuzZdWrbDwL4HHWw@mail.gmail.com>
Message-ID: <504346DC.4080801@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 09/01/2012 09:43 AM, Linus Walleij wrote:
> On Fri, Aug 31, 2012 at 8:20 AM, Greg Ungerer <gerg@snapgear.com> wrote:
>> Ok, tested on a KS8695 based machine. Boots and runs, obviously
>> clock is basically working. But 'date' never shows the time
>> increasing:
>>
>>    # date
>>    Thu Jan  1 00:00:00 UTC 1970
>>    # date
>>    Thu Jan  1 00:00:00 UTC 1970
>>    # date
>>    Thu Jan  1 00:00:00 UTC 1970
>>    #
>>
>> And yes, that did work before applying this patch :-)
>
> That mean clockevent is running but not clocksource.
>
> And I think that is because I forgot a ~ in the mask for disabling
> the T1 timer, so setting up the clockevent disables the clocksource ...
>
> I'll send out a fixed version, plese test!

Yep, I'll give it a try. I don't have the board in front of me
right now, but when I get in to the office tomorrow I can try it.


> (BTW I had not clue the 68K maintainer had a platform like
> this, fun!)

Ooohh, I have many weird and wonderful boards, across quite a few
different architectures. I seem to have collected and developed on
quite a few over to many years to remember.

Maintaining m68k/ColdFire is just for fun - it doesn't pay the bills
though :-)

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
