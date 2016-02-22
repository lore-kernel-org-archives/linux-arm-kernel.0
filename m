From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 22 Feb 2016 13:58:14 -0600
Subject: [PATCH] dma: mv_xor_v2: new driver
In-Reply-To: <20160222101621.4f03ef8b@free-electrons.com>
References: <1455523083-25506-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160222032730.GU19598@localhost>
 <20160222101621.4f03ef8b@free-electrons.com>
Message-ID: <CAL_Jsq+bYmafQWasY1T2QG6Dujf7Ki6JSZKZoFzJXAphTAvnCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 3:16 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello Vinod,
>
> On Mon, 22 Feb 2016 08:57:30 +0530, Vinod Koul wrote:
>> On Mon, Feb 15, 2016 at 08:58:03AM +0100, Thomas Petazzoni wrote:
>> > diff --git a/Documentation/devicetree/bindings/dma/mv-xor-v2.txt b/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
>> > new file mode 100644
>> > index 0000000..0a03dcf
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
>> > @@ -0,0 +1,19 @@
>> > +* Marvell XOR v2 engines
>> > +
>> > +Required properties:
>> > +- compatible: Should be "marvell,mv-xor-v2"
>> > +- reg: Should contain registers location and length (two sets)
>> > +    the first set is the DMA registers
>> > +    the second set is the global registers
>> > +- msi-parent: Phandle to the MSI-capable interrupt controller used for
>> > +  interrupts.
>> > +
>> > +Example:
>> > +
>> > +   xor0 at 400000 {
>> > +           compatible = "marvell,mv-xor-v2";
>> > +           reg = <0x400000 0x1000>,
>> > +                 <0x410000 0x1000>;
>> > +           msi-parent = <&gic_v2m0>;
>> > +           dma-coherent;
>> > +   };
>>
>> This should be a separate patch :)
>
> This is really a personal preference, and different maintainers have
> different opinions on the matter. However, if your preference is to
> have the DT binding documentation as a separate patch, then I'll split
> it, no problem :)

Read step 1 in Documentation/devicetree/bindings/submitting-patches.txt.

Rob
