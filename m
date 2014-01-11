From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 11 Jan 2014 04:03:59 +0300
Subject: [PATCH v4 0/2] ohci and ehci-platform clks, phy and dt support
In-Reply-To: <52D08122.606@redhat.com>
References: <1389393980-21183-1-git-send-email-hdegoede@redhat.com>
 <52D0875B.9040102@cogentembedded.com> <52D0799B.3030401@redhat.com>
 <52D08BF8.9090709@cogentembedded.com> <52D08122.606@redhat.com>
Message-ID: <52D0987F.7030703@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/11/2014 02:24 AM, Hans de Goede wrote:

>>>>> Here is v4 of my ohci and ehci-platform clks, phy and dt support patch-set,
>>>>> this version should be 100% ready for merging upstream.

>>>>     I see you've decided to completely ignore my opinion. NAK, FWIW.

>>> I'm sorry but the whole prefix thing has become a thing of
>>> -ETOOMUCHBIKESHEDDING,
>>> everyone except you seems to be fine with mmio

>>     Everyone being couple of people reading this thread? Of which only one
>> being familiar with the real [EO]HCI hardware? :-)

> You are aware that I've worked on qemu's USB emulation for 3 years full-time,
> including things like making the ehci emulation Windows XP compatible and
> many other hcd emulation fixes?

    Then you should have known that all [EO]HCI controllers use MMIO, and it's 
pointless to call them "MMIO [EO]HCI controller" in your title and in your 
"compatible" prop. Because you plainly create an impression that there's some 
other kind of [EO]HCI controllers out there, e.g. I/O mapped (for which a 
separate binding would be needed?).

> And Alan Stern's credentials speak for themselves.

    Yes, I meant Alan by [EO]HCI expert. He's not DT expert, unfortunately, AFAIK.

> Comments like this do not really help to get your own comments taken serious.

    Well, if nothing else helps... :-(

>>     The name is just plain stupid if you want to know my real opinion.

> Your opinion has been noted, but so far your entire objection seems to be
> you not liking the name and now calling it stupid, while there have been
> actually *technical* arguments against the other prefixes.

    I didn't hear your reply to my last mail which laid out some plan of 
dealing with ehci-ppc-of.c. Your "technical" argument against using "usb-ehci" 
didn't really make much sense to me and I told you why and what to do to get 
things right. You chose to not even reply to this and instead post "100% 
fready for merge" patchset.
    Sigh, it's a pity Alistair Popple's patches [1], [2] didn't get merged. He 
simply disappeared somewhere.

>> And you've posted v3 with this name used first only what, 1.5 days ago?

>>> and and one point in time we
>>> need to make a decision and move forward.

>>     I see the first version of your patches posted on January 6th, today is
>> 11th (just starting here). You must be in a very big hurry to get this
>> merged, I see. :-)

> This is not about being in a hurry, this is about not wanting to waste
> time on what is quickly turning into pure bike-shedding.

    Do you think calling other people's opinions "pure bike-shedding" helps 
the discussion?

>>     Serious changes like this are not really done at such pace. Only the
>> stuff that someone else has to painfully fix up later... :-(

> If you're suggestion that the mmio- prefix will cause breakage later now
> is your time to actually make an actual technical argument. "just plain
> stupid" does not help to get your comments taken serious.

    The worst thing is once the bindings get merged, they're "set in stone" 
and it won't be easy to fix, if at all possible... :-(

> Regards,

> Hans

[1] http://marc.info/?l=linux-usb&m=138508645219604
[2] http://marc.info/?l=linuxppc-embedded&m=138508628409947
