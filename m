From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 27 Jun 2013 11:54:11 +0200
Subject: [linux-sunxi] [PATCH 0/8] clocksource: sunxi: Timer fixes and
 cleanup
In-Reply-To: <20130627094307.GC8437@lukather>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
 <51CC0566.8010302@redhat.com> <20130627094307.GC8437@lukather>
Message-ID: <51CC0BC3.5090309@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/27/2013 11:43 AM, Maxime Ripard wrote:
> On Thu, Jun 27, 2013 at 11:27:02AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 06/26/2013 11:16 PM, Maxime Ripard wrote:
>>> Hi everyone,
>>>
>>
>> <snip>
>>
>>> It also finally adds a clocksource from the free running counter found in the
>>> A10/A13 SoCs.
>>
>> Hmm, have you benchmarked this? There have been reports from linux-sunxi kernel
>> users (xbmc project) that the waiting for the latch is quite slow. Note we
>> don't have anything better yet in the linux-sunxi kernel.
>
> No. I didn't.
>
> Do you have any pointers to these discussions?
>

The original discussion should be somewhere here:
https://groups.google.com/forum/#!forum/linux-sunxi

But I could not find it (it is probably hidden under
an unlogical subject).

Looking at my own notes (a small TODO file), I've
written down that the reporter reports:

  -current clocksource can cause us to run with interrupts disabled for 17%
   of the time, see "perf top" output

This is with a workload which does a lot of gettimeofday
calls.

I notice that unlike the sunxi-3.4 code you don't do any locking,
so how do you stop 2 clocksource calls from racing (and thus
getting a possible wrong value because of things not
being properly latched) ?

Regards,

Hans
