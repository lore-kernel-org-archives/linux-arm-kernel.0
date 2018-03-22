From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 22 Mar 2018 14:08:43 +0800
Subject: [linux-sunxi] Re: [PATCH 2/7] dt-bindings: add binding for the
 Allwinner A64 DE2 bus
In-Reply-To: <2866474.lRHIcLtROC@jernej-laptop>
References: <20180316175354.21437-1-icenowy@aosc.io>
 <20180320184646.dynqv6qubzabroe4@flea>
 <AAC74653-C6EB-4BE3-BB19-210687C1E158@aosc.io>
 <2866474.lRHIcLtROC@jernej-laptop>
Message-ID: <9520BDDE-BFE3-4220-B48D-01A00CFA94DE@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?3?22? GMT+08:00 ??1:13:42, "Jernej ?krabec" <jernej.skrabec@siol.net> ??:
>Hi all,
>
>Dne sreda, 21. marec 2018 ob 03:18:13 CET je Icenowy Zheng napisal(a):
>> ? 2018?3?21? GMT+08:00 ??2:46:46, Maxime Ripard
><maxime.ripard@bootlin.com> 
>??:
>> >On Sat, Mar 17, 2018 at 01:53:49AM +0800, Icenowy Zheng wrote:
>> >> All the sub-blocks of Allwinner A64 DE2 needs the SRAM C on A64
>SoC
>> >
>> >to
>> >
>> >> be claimed, otherwise the whole DE2 space is inaccessible.
>> >> 
>> >> Add a device tree binding of the DE2 part as a sub-bus.
>> >
>> >Where did you get the info that it was a bus?
>> 
>> There's no direct evidence, just some guess.
>> 
>> The DE2 is a whole part that is just allocated a memory
>> space at the user manual, and the SRAM controls the
>> access to all modules in the DE2.
>> 
>> So it might be a bus.
>> 
>> Implement it as a bus is a clear representation on A64.
>
>Since there is already syscon for same mmio region, we migh as well use
>it 
>when loading ccu-sun8i-de2 driver on A64.
>
>Other options, like SRAM driver or bus driver, might better represent
>HW, but 

I think the device tree should properly represent the HW,
it's a basic requirment.

>then we would have two DT nodes covering same mmio region, which I
>think is 
>not really acceptable.

It's acceptable, and DE2 is not the only user of SRAM controller so far.

VE will also need a SRAM region to be claimed.

>
>Any suggestions?
>
>BTW, H6 has same design in this regard.
>
>Best regards,
>Jernej
