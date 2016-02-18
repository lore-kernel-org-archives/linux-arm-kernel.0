From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 13:16:28 +0100
Subject: [PATCH v3 09/10] ARM: dts: introduce MPS2 AN385/AN386
In-Reply-To: <56C5A742.8010304@arm.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>
 <7245560.jfhuhtPsB8@wuerfel> <56C5A742.8010304@arm.com>
Message-ID: <5567140.dIBhKTnriP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 February 2016 11:13:06 Vladimir Murzin wrote:
> On 18/02/16 10:45, Arnd Bergmann wrote:
> > On Thursday 18 February 2016 10:11:37 Vladimir Murzin wrote:
> >>
> >> Right, I thought in a wrong way, in opposite it makes more sense now.
> >>
> >> .dtsi
> >>
> >> /* below the soc/ */
> >> smb {
> >>         compatible = "simple-bus";
> >>         #address-cells = <2>;
> >>         #size-cells = <1>;
> >>         ranges = <0 0 0x40200000 0x10000>,
> >>                  <1 0 0xa0000000 0x10000>;
> >> };
> > 
> > That looks good, yes.
> > 
> > Is 0x10000 the correct maximum addressable size of the external bus
> > in both cases?
> > 
> > Intuitively, I would guess that the 0xa0000000 range might
> > be much wider.
> 
> There is only Ethernet connected to this bus (apart from PSRAM), so it
> might be wider, but there is no indication of this in documentation.

I see this called "ahb_to_extmem16" in the documentation, which indicates
that it might be use 16 bits of address space, which would match
the 64K you listed.

For SSRAM1 / SSRAM2 / SSRAM3, a 8 MB address space is mentioned
and 16 MB for external PSRAM at 0x21000000.

	Arnd
