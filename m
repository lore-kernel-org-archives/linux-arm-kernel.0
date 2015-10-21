From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 21 Oct 2015 10:45:09 -0600
Subject: [PATCH RFT] ARM: bcm2835: enable all bcm2835-relevant in defconfig
In-Reply-To: <5627BA5F.104@lategoodbye.de>
References: <1444942061-23085-1-git-send-email-stefan.wahren@i2se.com>
 <5626F934.6090706@wwwdotorg.org> <5627BA5F.104@lategoodbye.de>
Message-ID: <5627C115.1050305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2015 10:16 AM, Stefan Wahren wrote:
> Am 21.10.2015 um 04:32 schrieb Stephen Warren:
>> On 10/15/2015 02:47 PM, Stefan Wahren wrote:
>>> Rebuild bcm2835_defconfig using "make bcm2835_defconfig;
>>> make savedefconfig", and add the following features:
>>>
>>> * Enable all bcm2835-relevant drivers (MBOX, WDT, DMA,
>>>    PWM, SND)
>>> * Re-enable some features to keep the current settings
>>>    (stackprotector, LED GPIO, LED triggers)
>>
>> Can you explain that second bullet a bit more?
>
> Yes, the last update to bcm2835_defconfig was on 25th September 2014.
> So a little bit changed in the configs like renaming of options.
> After saving the defconfig i noticed that we "lost" 2 features with
> the new defconfig:
>
> * CONFIG_CC_STACKPROTECTOR because of renaming to
> CONFIG_CC_STACKPROTECTOR_REGULAR
>
> * CONFIG_LEDS_TRIGGER_HEARTBEAT because of the following new dependencies
>    * CONFIG_NEW_LEDS
>    * CONFIG_LEDS_CLASS
>    * CONFIG_LEDS_TRIGGERS

Ah OK. It'd be nice to have that in the patch description.

> Do you want 2 separate patches (first update with re-enable and second
> with new bcm2835 stuff)?

It's probably fine as a single patch so long as all the changes (and 
reason why they're made) are described there.
