From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 02 Jan 2014 17:22:04 +0100
Subject: [RFC PATCH 0/3]  Fix i2c bus hang on A0 version of the Armada
 XP SoCs
In-Reply-To: <20140101192816.GP32537@lunn.ch>
References: <1388508293-9141-1-git-send-email-gregory.clement@free-electrons.com>
 <20140101192816.GP32537@lunn.ch>
Message-ID: <52C5922C.8050007@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 01/01/2014 20:28, Andrew Lunn wrote:
> On Tue, Dec 31, 2013 at 05:44:50PM +0100, Gregory CLEMENT wrote:
>> Hi,
>>
>> This series is an RFC to fix the i2c bus hang on A0 version of the
>> Armada XP SoCs. It occured on the the eraly release of the OpenBlocks
>> AX3-4 bords. Indeed the first variants of Armada XP SoCs (A0 stepping)
>> have issues related to the i2c controller which prevent to use the
>> offload mechanism and lead to a kernel hang during boot.
>>
>> The best solution will be to detect the SoCs version at runtime and
>> use it in the driver, but I chosed to submit this version in case CPU
>> version detection feature takes more time than expected (and we
>> already reached the rc6 kernel).
>>
>> Thanks,
>>
>> Gregory
> 
> Hi Gregory
> 
> Thanks for these RFC patches. I can confirm they work on my Openblocks
> device with an A0 stepping SoC. I can now access the RTC.
> 
> You missed adding the new DTS file to the Makefile. Depending on how
> the discussion goes about auto detecting stepping or not, i would of
> used different filenames, probably:

Thanks for your feedback. In case there will be a second version I will
take them into account. However I hope we won't need it as I sent a
new series to fix this bug by dynamically getting the SoC revision.

> 
> armada-xp-openblocks-ax3-4.dts
> armada-xp-openblocks-ax3-4-a0.dts
> armada-xp-openblocks-ax3-4-common.dts

you probably meant armada-xp-openblocks-ax3-4-common.dtsi, but I got the
point and I agree.

> 
> Keeps all the files together when listed alphabetically
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
