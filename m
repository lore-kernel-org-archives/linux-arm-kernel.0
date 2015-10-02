From: slash.tmp@free.fr (Mason)
Date: Fri, 2 Oct 2015 21:25:39 +0200
Subject: [PATCH] arm-soc: Add Sigma Designs Tango4 port
In-Reply-To: <20151002185337.GC21513@n2100.arm.linux.org.uk>
References: <560EAA7C.3070302@free.fr> <yw1xoaghl099.fsf@unicorn.mansr.com>
 <560EB1EC.3020403@free.fr> <20151002171334.GB21513@n2100.arm.linux.org.uk>
 <560EC863.8030600@free.fr> <20151002185337.GC21513@n2100.arm.linux.org.uk>
Message-ID: <560EDA33.9060905@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2015 20:53, Russell King - ARM Linux wrote:
> On Fri, Oct 02, 2015 at 08:09:39PM +0200, Mason wrote:
>> On 02/10/2015 19:13, Russell King - ARM Linux wrote:
>>
>>> Note also that vendor prefixes should be listed in
>>> Documentation/devicetree/bindings/vendor-prefixes.txt.  If it's not there,
>>> you need to propose a separate patch (to the devicetree mailing list) to
>>> add it, which must be done with their agreement.  Right now, the use of
>>> "sigma" as a prefix is entirely non-standard and not acceptable in DT
>>> files until this is done.
>>
>> As far as the upstreaming process is concerned, I speak for Sigma.
> 
> It doesn't matter who you speak for.  Your first patch should be to
> _only_ add the vendor ID to that file above, and to get it acked by
> the device tree maintainers.  That makes it "official" in the eyes of
> the developers responsible for maintaining the sanity of device tree.

OK. Mans took care of that in
"devicetree: add Sigma Designs vendor prefix"

> However, that has an impact on the above: you should therefore have
> access to the folk who know the origins of the interrupt controller,
> and whether it is a derivative of "sigma,smp8640-intc" or something
> else.  If "sigma,smp8640-intc" and "sigma,tango-intc" are jointly
> derived from a common ancestor, then you should not mention
> "sigma,smp8640-intc" at all.

I think there is some confusion surrounding Sigma's SoCs.

Briefly, Sigma Designs has gone through 4 major revisions of
its SoC architecture, Tango1 through Tango4. (Let's forget
Tango1 and Tango2, as they have fallen into oblivion.)

Within a major architecture, Sigma produces different designs,
sometimes just blowing fuses to differentiate packages, sometimes
actually adding hardware, or tweaking the design. These designs
are given "SMP8xxx" names, typically SMP86xx for Tango3 (MIPS)
and SMP87xx for Tango4 (ARM).

For example, SMP8756 is an ARM-based design, with a single
Cortex A9 core, while SMP8758 has two A9 cores.

SMP8640 was just one Tango3 SoC out of several. It's not special
in any way, as far as the interrupt controller is concerned.
I'll have to check the docs, but I seem to remember it has
remained unchanged throughout the Tango2-Tango4 period.
(But it will change in Tango5.)

This is why I insist on not committing to the smp8640-* nomenclature.
Because SMP8640 is nothing special in the Tango family.

Regards.
