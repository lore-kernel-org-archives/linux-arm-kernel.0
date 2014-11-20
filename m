From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 20 Nov 2014 12:48:35 -0800
Subject: [GIT PULL] ARM: BCM5301X: SoC changes for v3.19
In-Reply-To: <546E52E9.3040301@hauke-m.de>
References: <546298D9.7080800@hauke-m.de> <201411201027.22360.arnd@arndb.de>
 <546E52E9.3040301@hauke-m.de>
Message-ID: <546E53A3.3050005@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2014 12:45 PM, Hauke Mehrtens wrote:
> On 11/20/2014 10:27 AM, Arnd Bergmann wrote:
>> On Wednesday 12 November 2014, Hauke Mehrtens wrote:
>>> ----------------------------------------------------------------
>>> ARM: BCM5301X: SoC: two patches for the SoC part
>>>
>>> These patches were all send to the arm list and I haven't got any
>>> negative responses.
>>>
>>> ----------------------------------------------------------------
>>> Hauke Mehrtens (1):
>>>       ARM: BCM5301X: fix early serial console
>>>
>>> Rafa? Mi?ecki (1):
>>>       ARM: BCM5301X: select GPIOLIB as optional
>>
>> Hi Hauke and Florian,
>>
>> sorry for the late reply. The patches are both good and I want to merge them,
>> but I have two problems with your pull request:
>>
>> - I'm unsure about who is sending us patches for mach-bcm. I was under the
>>   assumption that Florian would now handle all of them and pick up your
>>   patches to forward them to arm at kernel.org together with the other mach-bcm
>>   platforms. I'd much rather get only patches from one person per platform
>>   directory, though we can have multiple people if that's what you all want.
> 
> I talked to Florian and he suggested me that I should send patches
> directly to you. There could be some stuff shared with the other network
> SoCs, there is nothing shared with the mobile SoCs.
> We thought that it would be easier for us (Florian and me) if you pull
> directly from me.

Absolutely, I did it differently for the Cygnus SoC to help Scott with
his initial submission, but in the future, I would rather have Hauke,
Scott and myself send separate pull requests, leaving you with just
potential conflicts for arch/arm/mach-bcm/{Makefile,Kconfig}.

If this model is not desirable, I have no problems aggregating all
mach-bcm changes to appropriate pull requests, whether that means
pulling from Hauke and Scott directly, or compiling pull requests myself
as long as you guys CC me on your patches.

Thanks!

> 
>> - The pull request is based on -rc4, but I see no strong reason why you did
>>   that. It helps us a lot of all pull requests in a branch are based off
>>   the same -rc, so please have them based on -rc1 by default or explain why
>>   you picked something else in the tag description.
> 
> I just thought that I should base it on a recent -rc, so I took -rc4, I
> can rebase it on rc1 if you like, I do not depend on any new stuff.
> 
>> If you want, I can just cherry-pick the two patches from your branch into
>> the next/soc branch so you don't have to rebase it this time.
> 
> That would be nice.
> 
> Hauke
> 
