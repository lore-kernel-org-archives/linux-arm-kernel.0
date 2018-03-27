From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Mar 2018 10:11:31 +0200
Subject: [linux-sunxi] Re: [PATCH 2/7] dt-bindings: add binding for the
 Allwinner A64 DE2 bus
In-Reply-To: <9A6A8961-D45C-4033-962E-83CCE8F01651@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io>
 <20180320184646.dynqv6qubzabroe4@flea>
 <AAC74653-C6EB-4BE3-BB19-210687C1E158@aosc.io>
 <2866474.lRHIcLtROC@jernej-laptop>
 <9520BDDE-BFE3-4220-B48D-01A00CFA94DE@aosc.io>
 <20180326222258.uxpgj4bk4pg56b7o@rob-hp-laptop>
 <9A6A8961-D45C-4033-962E-83CCE8F01651@aosc.io>
Message-ID: <20180327081131.hd652vkhohez2hcc@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 07:31:18AM +0800, Icenowy Zheng wrote:
> 
> 
> ? 2018?3?27? GMT+08:00 ??6:22:58, Rob Herring <robh@kernel.org> ??:
> >On Thu, Mar 22, 2018 at 02:08:43PM +0800, Icenowy Zheng wrote:
> >> 
> >> 
> >> ? 2018?3?22? GMT+08:00 ??1:13:42, "Jernej ?krabec"
> ><jernej.skrabec@siol.net> ??:
> >> >Hi all,
> >> >
> >> >Dne sreda, 21. marec 2018 ob 03:18:13 CET je Icenowy Zheng
> >napisal(a):
> >> >> ? 2018?3?21? GMT+08:00 ??2:46:46, Maxime Ripard
> >> ><maxime.ripard@bootlin.com> 
> >> >??:
> >> >> >On Sat, Mar 17, 2018 at 01:53:49AM +0800, Icenowy Zheng wrote:
> >> >> >> All the sub-blocks of Allwinner A64 DE2 needs the SRAM C on A64
> >> >SoC
> >> >> >
> >> >> >to
> >> >> >
> >> >> >> be claimed, otherwise the whole DE2 space is inaccessible.
> >> >> >> 
> >> >> >> Add a device tree binding of the DE2 part as a sub-bus.
> >> >> >
> >> >> >Where did you get the info that it was a bus?
> >> >> 
> >> >> There's no direct evidence, just some guess.
> >> >> 
> >> >> The DE2 is a whole part that is just allocated a memory
> >> >> space at the user manual, and the SRAM controls the
> >> >> access to all modules in the DE2.
> >> >> 
> >> >> So it might be a bus.
> >> >> 
> >> >> Implement it as a bus is a clear representation on A64.
> >> >
> >> >Since there is already syscon for same mmio region, we migh as well
> >use
> >> >it 
> >> >when loading ccu-sun8i-de2 driver on A64.
> >> >
> >> >Other options, like SRAM driver or bus driver, might better
> >represent
> >> >HW, but 
> >> 
> >> I think the device tree should properly represent the HW,
> >> it's a basic requirment.
> >> 
> >> >then we would have two DT nodes covering same mmio region, which I
> >> >think is 
> >> >not really acceptable.
> >> 
> >> It's acceptable, and DE2 is not the only user of SRAM controller so
> >far.
> >
> >No, it's not acceptable. Don't create overlapping mmio regions in DT.
> 
> Then should the SRAM controller driver be configured to take the syscon?

We could have a single DT node that would export a syscon yes, just
like you did for the R40 ethernet case.

I'm not sure the SRAM controller itself needs to take the syscon, it
just can export its own.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180327/d40921bc/attachment-0001.sig>
