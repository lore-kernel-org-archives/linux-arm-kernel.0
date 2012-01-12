From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Jan 2012 12:03:48 +0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A83A@HQMAIL01.nvidia.com>
References: <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E6B@HQMAIL01.nvidia.com>
 <20120107135445.GI4790@S2101-09.ap.freescale.net>
 <20120108125156.GB2203@richard-laptop>
 <20120109015625.GE1835@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A6FB@HQMAIL01.nvidia.com>
 <20120111235634.GG20968@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A83A@HQMAIL01.nvidia.com>
Message-ID: <20120112040345.GA21802@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 03:59:26PM -0800, Stephen Warren wrote:
> Shawn Guo wrote at Wednesday, January 11, 2012 4:57 PM:
> > This is somehow overkilled to me.  Doing this will create a big mount
> > of .dtsi files to bloat folder arch/arm/boot/dts.  Putting the
> > 'combinations' in <soc>.dtsi seems perfect fine to me.
> 
> I see a couple problems with that approach:
> 
> 1) <soc>.dtsi gets very bloated,

In theory, it's possible.  But in the real world, I do not think this
will be an issue.  From the experience from working on previous imx
platforms, the mux chosen on Freescale reference design board will
likely be reused on custom boards much.

> and wastes space containing board-
> specific data for boards other than the "current" one.

Technically, it's not the board specific data, because what pins can
be put together consisting of a function is really soc specific.

> 
> 2) We need to invent some more complex DT format so you can reference
> these canned combinations from the device drivers, rather than simply
> enumerating the mux value for each pin/group.

Sorry, I do not get that.

Regards,
Shawn

> 
> You could put the combination .dtsi files in arch/arm/boot/dts/<soc> to
> maintain some extra order.
