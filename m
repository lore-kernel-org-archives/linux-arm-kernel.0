From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 28 Apr 2015 20:41:45 -0700
Subject: BCM2836 (Raspberry Pi 2) port
In-Reply-To: <5540443C.8070604@wwwdotorg.org>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <5540443C.8070604@wwwdotorg.org>
Message-ID: <554052F9.5040305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/28/15 19:38, Stephen Warren a ?crit :
> On 04/21/2015 12:09 PM, Eric Anholt wrote:
>> This is my first submission of a Raspberry Pi 2 port.  It can be found
>> at https://github.com/anholt/linux/tree/bcm2836
>>
>> I'm using the 2835 interrupt controller support, without adding the
>> checks for ARM local interrupts first.  That means no support for IPIs
>> (and thus no SMP), no PMU events, and no local timer (I'm using the
>> same 2835 peripheral one).
>>
>> It supports a similar featureset to Pi 1 at this point.  Serial and SD
>> cards work.  Just one CPU supported.  USB (ethernet) works if you use
>> U-Boot, or my mailbox series
>> (https://github.com/anholt/linux/tree/bcm2836-mbox).
> 
> Tested-by: Stephen Warren <swarren@wwwdotorg.org>
> 
> I applied the patches on top of korg's linux-rpi.git for-rpi-next,
> resolved the io_map conflicts, and tested without U-Boot.

Should we start thinking about routing bcm2835/36 changes through the
same Broadcom pull request as we do for the every other SoCs within
mach-bcm: 63xx, 53xx/47xx, brcmstb, cygnus at some point?

I don't have any strong feelings either way, just curious if this is
something remotely desireable from an arm-soc maintainer role perspective.

Thanks!
--
Florian
