From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 22 Oct 2015 10:49:06 +0200
Subject: [linux-sunxi] Re: [PATCH 0/6] ARM: sunxi: Introduce Allwinner H3
 support
In-Reply-To: <562894FE.3040702@gmail.com>
References: <1445444007-4260-1-git-send-email-jenskuske@gmail.com>
 <5627E515.6050505@redhat.com> <562894FE.3040702@gmail.com>
Message-ID: <5628A302.1080908@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22-10-15 09:49, Jens Kuske wrote:
> Hi,
>
> On 21/10/15 21:18, Hans de Goede wrote:
>>
>> Great to see that you've started working on this again. Last weekend I
>> ended up working on this too together with Reinder E.N. de Haan <reinder@mveas.com>
>> (added to the Cc).
>>
>> We took a slightly different approach for the gates clocks, see:
>>
>> https://github.com/jwrdegoede/linux-sunxi/commits/sunxi-wip
>>
>> And specifically:
>>
>> https://github.com/jwrdegoede/linux-sunxi/commit/80a1afe319d5d1a0c426d42e75d37f0c64e8ea0b
>>
>> Combined with:
>>
>> https://github.com/jwrdegoede/linux-sunxi/commit/d508da5feb5048f6674d6b24b58ac9058fb9d877
>>
>> This deals with the per gate parents the same way the rockchip
>> clock code does, and it seems to be quite a bit less code then your solution.
>>
>> So now we've two solutions to chose from :) Since you seem to be back to
>> working on this I'll refrain from doing any further work, at least
>> without coordinating. Maxime, can you let us know which solution for the
>> gates clock parents is best, or tell us if you think both solutions are
>> no good :)
>
> I'd actually prefer your solution. I duplicated the simple-gates code
> when trying a different approach and never revisited that decision.

Ok, note then when you switch to my solution (or the improved version of it
or the improved version Jean-Francois Moine suggests) the dtsi now has a list
of clocks with one per gate, rather then clock indices. You can save yourself
some time by taking that list from the dtsi patch in my tree, rather then
building it yourself manually.

>> (I wanted to get in touch with you about the work done this weekend,
>> but your posting of this v3 has sorta pre-empted that).
>>
>> Other then the slightly different solution for the gates, the code in my tree
>> is a straight forward port of your v2.
>>
>> Thanks for your work on this!
>>
>> Regards,
>>
>> Hans
>>
>>
>> p.s.
>>
>> I'm teaching a kernel driver course at my local hackerspace in the netherlands:
>>
>> https://revspace.nl/KernelDriverProgrammingCourse2015
>>
>> Which is where our work on this this weekend originated. The next planned
>> course day is November 1st and I expect Reinder to be working on the H3
>> again then. I think the plan was to tackle USB next. Reinder can you confirm
>> this ?  If you (Jens) want to work on USB before then, that is fine, but please
>> coordinate their is plenty to do, so no need for us to be doing (more) double
>> work.
>>
>
> I don't plan to work on USB soon, my next step would have been Ethernet
> and finishing the basic u-boot support. You know my u-boot H3 wip tree I
> hope? Before we duplicate our work there too...
> https://github.com/jemk/u-boot-sunxi/tree/sunxi/h3

I was not aware of that work, at a first glance it looks good. Can you rebase
this on top of current u-boot/master (or v2015.10) and then submit it upstream ?

2 questions which come to mind immediately:

1) Where does the dram init logic come from, AFAIK Allwinner has not provided
any H3 dram init code ?

2) I see no pmic code in there. I know these boards do not use an axp pmic,
but according to my info at least the Orange Pi 2 (which I have) uses a
sy8106a pmic, it is not entirely clear to me yet if this one needs any
init though, I've mailed the Orange Pi people about this.

Regards,

Hans
