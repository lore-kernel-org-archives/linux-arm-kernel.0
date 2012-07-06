From: olof@lixom.net (Olof Johansson)
Date: Fri, 6 Jul 2012 16:24:32 -0700
Subject: [PATCH 1/1] ARM: add PROC_DEVICETREE support in Kconfig
In-Reply-To: <CAERv70uZMEoX4OcECssOrktVzC911tiSLXRH56TjyhQqVgNwBA@mail.gmail.com>
References: <1341571127-14461-1-git-send-email-jgq516@gmail.com>
 <4FF6DCCA.2080509@gmail.com>
 <CAERv70uZMEoX4OcECssOrktVzC911tiSLXRH56TjyhQqVgNwBA@mail.gmail.com>
Message-ID: <CAOesGMjmeXVx2MR7GGux9Cztkf-C3cBqpBW1_PW75D_Gk0GHiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 6, 2012 at 4:15 PM, Xiao Jiang <jgq516@gmail.com> wrote:
> 2012/7/6 Rob Herring <robherring2@gmail.com>
>>
>> On 07/06/2012 05:38 AM, jgq516 at gmail.com wrote:
>> > From: Xiao Jiang <jgq516@gmail.com>
>> >
>> > Since more and more arm chips support device tree, it'd be better add
>> > PROC_DEVICETREE
>> > in arch/arm/Kconfig to avoid duplicate code.
>>
>> I think this should remain user choice. If its going to be selected,
>> then you might as well just remove the option altogether. Perhaps just
>> make the option default to yes.
>>
> Hmm, sounds reasonable from your point. So the better choice is to set the
> option default to Y if the board has dt support just like tegra_defconfig
> and at91_dt_defconfig,  right? thanks.

Why bother? If the defconfigs select it then most users basing their
config from that will be just fine.

PROC_DEVICETREE is 100% optional, it's useful to get runtime access to
the contents of the device tree but it's not required for the kernel
to boot.


-Olof
