From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 11:45:12 +0100
Subject: [PATCH v3 09/10] ARM: dts: introduce MPS2 AN385/AN386
In-Reply-To: <56C598D9.3030001@arm.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>
 <7272921.u1gphgWzUn@wuerfel> <56C598D9.3030001@arm.com>
Message-ID: <7245560.jfhuhtPsB8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 February 2016 10:11:37 Vladimir Murzin wrote:
> 
> Right, I thought in a wrong way, in opposite it makes more sense now.
> 
> .dtsi
> 
> /* below the soc/ */
> smb {
>         compatible = "simple-bus";
>         #address-cells = <2>;
>         #size-cells = <1>;
>         ranges = <0 0 0x40200000 0x10000>,
>                  <1 0 0xa0000000 0x10000>;
> };

That looks good, yes.

Is 0x10000 the correct maximum addressable size of the external bus
in both cases?

Intuitively, I would guess that the 0xa0000000 range might
be much wider.

> .dts
> 
> smb {
>         ethernet at 0,0 {
>                 compatible = "smsc,lan9220", "smsc,lan9115";
>                 reg = <0 0x0 0x10000>;
>                 interrupts = <13>;
>                 interrupt-parent = <&nvic>;
>                 smsc,irq-active-high;
> };
> 
> 
> and looking again at .dtsi it seems to me that fpgaio should be moved
> below the soc/ under separate bus interface which would hosts audio and
> spi too or I keep missing things around device-tree?
> 

I don't see the audio and spi nodes, so I'm not sure where exactly
you would put them.

Ideally those things should be visible from a block diagram in the
datasheet.

	Arnd
