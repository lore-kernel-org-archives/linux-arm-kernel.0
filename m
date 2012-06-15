From: wni@nvidia.com (Wei Ni)
Date: Fri, 15 Jun 2012 14:09:41 +0800
Subject: Where to power on the wifi device before loading the driver.
In-Reply-To: <4FDA092E.10301@wwwdotorg.org>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD90352.9090606@wwwdotorg.org>
 <20120614063120.GA20167@avionic-0098.mockup.avionic-design.de>
 <20120614121234.GC3913@opensource.wolfsonmicro.com>
 <4FDA092E.10301@wwwdotorg.org>
Message-ID: <6B4D417B830BC44B8026029FD256F7F1C377BFFE8D@HKMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 23:54:22, Stephen Warren wrote:
>>>> The core of the issue is that:
>>
>>>> * Tegra30 support is via device tree. * We have an SDIO bus, and 
>>>> the WiFi device attached to that bus is enumerable. * Since the 
>>>> WiFi device is enumerable, no node exists in the DT to represent 
>>>> it. * However, the driver for the WiFi device needs certain 
>>>> information, such as the reset GPIO ID and perhaps power GPIO.
>>
>>> PCI devices are also enumerable and yet they can be matched up with 
>>> nodes in the device tree. Perhaps something similar could be added 
>>> for the SDIO bus?
>>
>> This seems to make the most sense - pushing this through the 
>> regulator API is just a bodge.
>
>Yes, that seems reasonable.
>
>Presumably the power GPIO should be a fixed regulator though, since it 
>is a power control not just a plain old GPIO? That said, the current driver apparently deals with this as a GPIO already.
>
>The reset GPIO can separately/directly controlled by the WiFi driver though.

I talked with Franky, this power sequence is generally for 4329, so it mean this sequence can be put into the wifi driver.
We can use the virtual platform device both for OOB and non OOB.
I will send out patches later.

---
nvpublic
