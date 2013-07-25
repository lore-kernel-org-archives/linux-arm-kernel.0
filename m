From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Thu, 25 Jul 2013 22:33:46 +0200
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC
 with ARM CPU
In-Reply-To: <20130724225443.GA29801@glitch>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
 <20130716151435.GB3871@linaro.org> <2043662.BcW19XTTMG@lenovo>
 <20130723184907.GA6811@ohporter.com>
 <CAGVrzcbA72AYu6J3JXBirQQeTiDH9cJThdBdH=Q=gJtOnqz-AA@mail.gmail.com>
 <20130723192203.GC6811@ohporter.com> <51EF1B8C.9020304@broadcom.com>
 <CADjby3WGW6f=1Vdm2kx+Re0KrjFRaC3dQOumpnS6_sp2yb5NfQ@mail.gmail.com>
 <51F02947.7020301@hauke-m.de> <20130724225443.GA29801@glitch>
Message-ID: <51F18BAA.1050806@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2013 12:54 AM, Domenico Andreoli wrote:
> On Wed, Jul 24, 2013 at 09:21:43PM +0200, Hauke Mehrtens wrote:
>> On 07/24/2013 02:44 AM, Domenico Andreoli wrote:
>>> On Wednesday, July 24, 2013, Hauke Mehrtens <hauke@hauke-m.de
>>> <mailto:hauke@hauke-m.de>> wrote:
>>>> On 07/19/2013 03:36 AM, Domenico Andreoli wrote:
>>>>> On Tue, Jul 16, 2013 at 05:35:21PM +0200, Hauke Mehrtens wrote:
>>>>>> On 07/16/2013 05:20 PM, Thomas Petazzoni wrote:
>>>>>>>
>>>>>>>> diff --git a/arch/arm/mach-bcm53xx/Kconfig
>>> b/arch/arm/mach-bcm53xx/Kconfig
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000..1e16e87
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/arch/arm/mach-bcm53xx/Kconfig
>>>>>>>> @@ -0,0 +1,10 @@
>>>>>>>> +config ARCH_BCM53XX
>>>>>>>> +  bool "Broadcom BCM47XX / BCM53XX ARM SoC"
>>>>>>>
>>>>>>> So the directory is named mach-bcm53xx, but you also handle BCM47xx
>>>>>>> SoCs. This doesn't sound really easy to follow.
>>>>>
>>>>> At the time of the BCM281XX merge we considered that such directories
>>> would
>>>>> mostly contain board files only, being these new entries DT based. Hence
>>>>> the choice of mach-bcm to collect all of them.
>>>>>
>>>>> I think you should then put this stuff there.
>>>>
>>>> So you think I should move the file from
>>>> arch/arm/mach-bcm53xx/bcm53xx.c to arch/arm/mach-bcm/bcm53xx.c ?
>>>
>>> yes
>>>
>>> this looks more comsistent with the actual soc name:
>>> arch/arm/mach-bcm/bcm530xx.c
>>>
>>> but I find also acceptable the complete name of the "parent" soc (as I'm
>>> doing with the bcm4760), so: arch/arm/mach-bcm/bcm53010.c
>>
>> I do not think these Broadcom ARM SoCs (bcm4760, BCM5301X, bcm11351)
>> have more in common than the vendor name, so I do not think it is a good
>> idea to place them all at mach-bcm.
> 
> In an ideal DT-only world (as basically is for Broadcom ARM SoCs), whatever
> two or more SoCs share can hopefully modelled in a driver and as such
> would go in the drivers/ subtree. What's left is really SoC specific and,
> again hopefully, very minimal.
> 
> There should not be any SoC so weird to require a whole subdirectory full
> of that SoC specific stuff. So grouping everything by vendor name looks
> quite appealing to me.
> 
> Sharing the same subdir requires people working in it to talk and find
> agreements some more than the sparsely populated subdir did (because there
> is not a single maintainer who owns it). I think this is a big advantage
> Broadcomers can start with right now.

I want to be able to build the BCM5301X SoC without building the current
CONFIG_ARCH_BCM, so what name do you suggest for board_bcm.o ?

My plan would be to make CONFIG_ARCH_BCM just activate the Broadcom
submenu, but not build any code. Then the list of Broadcom SoCs is
opened like CONFIG_ARCH_BCM5301X and the "old" CONFIG_ARCH_BCM.

Hauke
