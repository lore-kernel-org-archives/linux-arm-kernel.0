From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Jan 2017 13:36:40 +0530
Subject: [3/3] ARM: da850: Add ti, da830-uart compatible for serial ports
In-Reply-To: <2982bdd0-0997-f4a7-71c3-9d232237cc23@ti.com>
References: <1482265384-715-4-git-send-email-david@lechnology.com>
 <2982bdd0-0997-f4a7-71c3-9d232237cc23@ti.com>
Message-ID: <11bdcd56-de34-a5ff-7af5-24e4a0e8cd2c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 December 2016 09:36 PM, Franklin S Cooper Jr wrote:
> 
> 
> On 12/20/2016 02:23 PM, David Lechner wrote:
>> TI DA8xx/OMAPL13x/AM17xx/AM18xx SoCs have extra UART registers beyond
> 
> Similar comment about adding Keystone SoCs to the list of SoCs.
> 
>> the standard 8250 registers, so we need a new compatible string to
>> indicate this. Also, at least one of these registers uses the full 32
>> bits, so we need to specify reg-io-width in addition to reg-shift.
>>
>> "ns16550a" is left in the compatible specification since it does work
>> as long as the bootloader configures the SoC UART power management
>> registers.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>  arch/arm/boot/dts/da850.dtsi | 9 ++++++---
> 
> Similar changes should be made to the various Keystone dtsi files.

That will be a different patch though since the two changes will go
through different trees. And I strongly suspect David does not have
access to a keystone board. So it will have to be done by someone at TI.

Thanks,
Sekhar
