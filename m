From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 7 May 2012 16:14:42 +0530
Subject: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain & PRM
 support for AM33XX device
In-Reply-To: <4FA7A4D0.80006@ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9EA07A@DBDE01.ent.ti.com>
 <20120418231837.GT21106@atomide.com>
 <79CD15C6BA57404B839C016229A409A83E9F9C2D@DBDE01.ent.ti.com>
 <20120426184312.GY3739@atomide.com>
 <79CD15C6BA57404B839C016229A409A83E9FF9EA@DBDE01.ent.ti.com>
 <20120426190524.GZ3739@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA008E5@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1205020255150.19695@utopia.booyaka.com>
 <4FA7A4D0.80006@ti.com>
Message-ID: <CAMQu2gxmPAEWYmE+DLHNYii1-wtjkm68mxU89F8EXyGLQP1Tww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2012 at 4:02 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Paul,
>
>
> On 5/2/2012 11:09 AM, Paul Walmsley wrote:
>>
>> On Fri, 27 Apr 2012, Hiremath, Vaibhav wrote:
>>
>>> I will be waiting for your comment and conformation on, which family
>>> AM33xx
>>> device should fall in? Please refer to the mail-chain -
>>>
>>> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg67275.html
>>
>>
>> This decision turns out to be pretty important; it certainly affects the
>> AM33xx PRM/CM/clockdomain/powerdomain patches that I've been looking at.
>>
>> Here is my suggestion, based on our previous practice. ?I am not so
>> sure that it is the best way, but it seems pretty reasonable"
>>
>> Using CONFIG_ARCH_OMAP3 for CONFIG_ARCH_OMAPAM33XX doesn't make sense, as
>> far as I can tell. ?The main area of similarity between the other
>> CONFIG_ARCH_OMAP3 and AM33xx is the Cortex-A8. ?And even that MPU
>> subsystem is quite different between, say, the 3430/3630 and the AM33xx.
>> Most of the AM33xx is quite different from the 3430/3630: OMAP4-style PRCM
>> interface, OMAP4-style interconnect, etc. ?Plus, most of the
>> CONFIG_ARCH_OMAP3 code in our codebase is very 3430/3630-specific, like
>> the PM code.
>>
>> This would seem to suggest that we should use CONFIG_ARCH_OMAP4. ?But that
>> option currently assumes an OMAP4-style MPU subsystem: SMP Cortex-A9,
>> PL310, etc. ?None of that is true for AM335x.
>>
>> So first we have to decide whether the CONFIG_ARCH_OMAP* options should
>> have a strong dependency on the MPU type, as they currently do; or whether
>> they should focus on the way the SoC is integrated.
>
>
> I think as well that these devices should be considered as part of the OMAP4
> family.
> The CPU type should not be the parameter that decide the OMAP family, it is
> just an IP, that can change on some variant, whereas the whole PRCM
> infrastructure / interconnect is mostly the same.
>
I agree. In fact more and more I think of this problem, looks like we
should get rid
off ARCH_OMAP* and just is SOC_* going forward.

Common ARM code already takes care of different CPU version and as Benoit
mentioned it is just one of the IP in the entire SOC. I saw tony commenting
in similarly on of the patch set.

Regards
Santosh
