From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 31 Oct 2013 13:54:42 +0100
Subject: [PATCH 1/2] ARM: kirkwood: add support for OpenBlocks A7 platform
In-Reply-To: <20131031125030.GJ26784@titan.lakedaemon.net>
References: <1383152110-19577-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1383152110-19577-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20131030195724.GI26784@titan.lakedaemon.net> <20131031093735.68aa7df1@skate>
 <52722037.8050808@free-electrons.com> <20131031102123.5eff2255@skate>
 <20131031125030.GJ26784@titan.lakedaemon.net>
Message-ID: <52725312.4090208@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/10/2013 13:50, Jason Cooper wrote:
> On Thu, Oct 31, 2013 at 10:21:23AM +0100, Thomas Petazzoni wrote:
>> Dear Gregory CLEMENT,
>>
>> On Thu, 31 Oct 2013 10:17:43 +0100, Gregory CLEMENT wrote:
>>
>>>> Strange. 'make dtbs' was working here. What was wrong exactly? Just
>>>> that the unit address (@90000) didn't match the starting address
>>>> 0x1c0000 ?
>>>
>>> The unit address has no special meaning for the device tree it's just a
>>> way to give a unique name to a node right?
>>
>> Yes, that's also my understanding.
> 
> Correct, that's not what caused the error.
> 
>>> So in this case it is not really a problem, but it's just nicer for the
>>> coherency of the information in the dt to have the unit address which match
>>> the starting address.
>>
>> Indeed, it's much better if they match (shame on me for the silly
>> copy/paste), but having then *not* matching should not cause any DTC
>> error, I believe.
>>
>>> I also do a make dtbs ans I didn't get any errors:
>>> $ make dtbs
>>>  [...]
>>>   DTC     arch/arm/boot/dts/kirkwood-openblocks_a6.dtb
>>>   DTC     arch/arm/boot/dts/kirkwood-openblocks_a7.dtb
>>
>> Same here.
> 
> With Thomas' original patch (on top of mvebu/dt, based on v3.12-rc1):

On my side I tested the patch on top on v3.12-rc7. So the difference should
be there.

> 
> $ make kirkwood_defconfig
> $ make dtbs
> ...
>   DTC     arch/arm/boot/dts/kirkwood-openblocks_a6.dtb
>   DTC     arch/arm/boot/dts/kirkwood-openblocks_a7.dtb
> Warning (reg_format): "reg" property in /ocp at f1000000/nand at 3000000/partition at 0 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> Warning (reg_format): "reg" property in /ocp at f1000000/nand at 3000000/partition at 90000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> Warning (reg_format): "reg" property in /ocp at f1000000/nand at 3000000/partition at d4000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> Warning (reg_format): "reg" property in /ocp at f1000000/nand at 3000000/partition at f4000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> Warning (reg_format): "reg" property in /ocp at f1000000/nand at 3000000/partition at 4f4000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> Warning (reg_format): "reg" property in /ocp at f1000000/nand at 3000000/partition at 2214000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> Warning (avoid_default_addr_size): Relying on default #address-cells value for /ocp at f1000000/nand at 3000000/partition at 0
> Warning (avoid_default_addr_size): Relying on default #size-cells value for /ocp at f1000000/nand at 3000000/partition at 0
> Warning (avoid_default_addr_size): Relying on default #address-cells value for /ocp at f1000000/nand at 3000000/partition at 90000
> Warning (avoid_default_addr_size): Relying on default #size-cells value for /ocp at f1000000/nand at 3000000/partition at 90000
> Warning (avoid_default_addr_size): Relying on default #address-cells value for /ocp at f1000000/nand at 3000000/partition at d4000
> Warning (avoid_default_addr_size): Relying on default #size-cells value for /ocp at f1000000/nand at 3000000/partition at d4000
> Warning (avoid_default_addr_size): Relying on default #address-cells value for /ocp at f1000000/nand at 3000000/partition at f4000
> Warning (avoid_default_addr_size): Relying on default #size-cells value for /ocp at f1000000/nand at 3000000/partition at f4000
> Warning (avoid_default_addr_size): Relying on default #address-cells value for /ocp at f1000000/nand at 3000000/partition at 4f4000
> Warning (avoid_default_addr_size): Relying on default #size-cells value for /ocp at f1000000/nand at 3000000/partition at 4f4000
> Warning (avoid_default_addr_size): Relying on default #address-cells value for /ocp at f1000000/nand at 3000000/partition at 2214000
> Warning (avoid_default_addr_size): Relying on default #size-cells value for /ocp at f1000000/nand at 3000000/partition at 2214000
> 
> thx,
> 
> Jason.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
