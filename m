From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Tue, 25 Sep 2012 10:28:17 +0200
Subject: [PATCH] arm: make FORCE_MAX_ZONEORDER configurable for TI AM33XX
In-Reply-To: <20120925081449.GF31374@n2100.arm.linux.org.uk>
References: <1341325242-17638-1-git-send-email-yegorslists@googlemail.com>
 <20120924171858.GG28835@atomide.com>
 <CAGm1_ks_GvSTH8DJ6d3R5OjPNEOhQ39hNo4grg1Pn-NqFX5VKQ@mail.gmail.com>
 <20120924231619.GA28941@n2100.arm.linux.org.uk>
 <20120925003758.GP28835@atomide.com> <506165CA.7070406@visionsystems.de>
 <20120925081449.GF31374@n2100.arm.linux.org.uk>
Message-ID: <50616B21.3070909@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.09.2012 10:14, Russell King - ARM Linux wrote:
> On Tue, Sep 25, 2012 at 10:05:30AM +0200, Yegor Yefremov wrote:
>> How should I change the patch to make it proper? SA1111 is broken anyway:
> No it isn't.  This is what it produces _today_, and has done for the last
> 5-10 years without modification
>
> # CONFIG_CLEANCACHE is not set
> # CONFIG_FRONTSWAP is not set
> CONFIG_FORCE_MAX_ZONEORDER=9
> CONFIG_LEDS=y
> CONFIG_LEDS_CPU=y
>
>> config FORCE_MAX_ZONEORDER
>>         int "Maximum zone order" if ARCH_SHMOBILE
>>         range 11 64 if ARCH_SHMOBILE
>>         default "9" if SA1111
>>         default "11"
>>
>> AFAIK if ARCH_SHMOBILE defines dependency on ARCH_SHMOBILE,
> No it doens't.
>
> 	int "Maximum zone order" if ARCH_SHMOBILE
>
> is far from being the same as:
>
> 	int "Maximum zone order"
> 	depends on ARCH_SHMOBILE
>
> The former defines a condition upon which the option is offered in GUIs -
> or to put it another way, it defines the visibility of the option.
>
> The latter defines a dependency which must be met for the option to be
> both visible and appear in the resulting configuration file.
>
>> so SA1111 won't be evaluated (at least if I select SA1111
> And did you check that SA1111 remains selected?  I bet you didn't.  Or
> maybe you tested your patched version.  Whatever.  The original works,
> and has been known to work for years.  Your patch breaks it.  It's
> really as simple as that.

Thanks for explanation. I think I've got it now. Please review the v2 version.

Yegor
