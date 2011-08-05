From: scottwood@freescale.com (Scott Wood)
Date: Fri, 5 Aug 2011 16:48:39 -0500
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <CAKGA1b=CFVwjHT7eobd1-UMrSBNsQ2N+96OuCu1QbjGgo9RScQ@mail.gmail.com>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
	<CAKGA1bmbWUeyhUtDwHZjB8V4e2wJ0NHX2qWhqaqx6HoBm7uMnQ@mail.gmail.com>
	<4E3C51F5.50707@freescale.com>
	<20110805203629.GB6991@huya.qualcomm.com>
	<CAKGA1b=CFVwjHT7eobd1-UMrSBNsQ2N+96OuCu1QbjGgo9RScQ@mail.gmail.com>
Message-ID: <4E3C6537.2080602@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2011 04:29 PM, Matt Sealey wrote:
> On Fri, Aug 5, 2011 at 3:36 PM, David Brown <davidb@codeaurora.org> wrote:
>> On Fri, Aug 05, 2011 at 03:26:29PM -0500, Scott Wood wrote:
>>
>>>> Yes, it puts the onus of the work on the firmware guys, but they're
>>>> the ones writing the device trees for their hardware anyway.
>>>
>>> Sometimes.
>>
>> I'm not even sure that is going to be common.  At least our setup is
>> going to have the device tree living in flash somewhere.  The
>> bootloader only knows enough about the FDT to insert arguments and
>> memory information into it.  They certainly aren't the appropriate
>> team to be defining the device tree.
>>
>> David
> 
> In any company through some kind of collaborative process of firmware
> and Linux development, someone sits down and defines this device tree.
> They will have an intimate knowledge of the hardware.. 

That doesn't mean they have intimate knowledge of what will be accepted
upstream, or that they involve upstream early enough.  Even within the
company, those who work with upstream may have little influence over
what gets flashed on the boards during manufacturing, or when hardware
details can be disclosed in the form of submitting patches.  Or they
might have just been rushed by schedule to get some firmware done that
can load a kernel so boards can be shipped, and enabling certain
peripherals gets dealt with later.

> if you have to
> flash the device tree to NOR or NAND or EEPROM or something anyway,
> then flashing a new firmware binary at the same time is not really any
> more complex.

If the firmware doesn't depend on the device tree to boot, you don't
need to worry about bricking the board by reflashing the device tree.

> So why not take the complexity and choice out of it, and do it in the
> firmware,, one list, all configured at boot time, before Linux is even
> in the picture, and make sure this is a requirement for booting Linux
> that these pins are set up already?

I fully agree that that's the nicer approach -- if you're not yet in a
position where you need to support existing firmware.  Is that the case
here?

-Scott
