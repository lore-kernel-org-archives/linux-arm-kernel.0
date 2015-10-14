From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Oct 2015 22:07:06 +0200
Subject: [PATCH 2/5] arm: dts: lpc32xx: fix improper usage of ranges
 property
In-Reply-To: <CAGhQ9VzKrsAYy=xwEZPD80jaTxmqR5MJj7fXeFTK-A2JnJXPqA@mail.gmail.com>
References: <1444694045-22000-1-git-send-email-vz@mleia.com>
 <7163229.YtgKU9kxxJ@wuerfel>
 <CAGhQ9VzKrsAYy=xwEZPD80jaTxmqR5MJj7fXeFTK-A2JnJXPqA@mail.gmail.com>
Message-ID: <19392174.3eZzHlAnnT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 October 2015 19:23:09 Joachim Eastwood wrote:
> >
> > /ahb5 {
> >         ranges = <0 0x20000000 0x10000000>;
> >
> >         apb {
> >                 ranges = <0 0x80000 0x20000>;
> >         };
> > };
> > /ahb6 {
> >         ranges = <0 0x30000000 0x10000000>,           /* AHB registers */
> >                  <0x80000000 0x80000000 0x40000000>, /* EMC DYCS0/1 */
> >                  <0xE0000000 0xE0000000 0x04000000>; /* EMC CS0-3 */
> >
> >         memory-controller at 1080000 {
> >                 reg = <0x1080000 0x10000>;
> >         };
> > };
> 
> Sorry for hijacking the thread, but I have related question to this.
> 
> What is the advantage of using a hierarchical bus structure in dt?
> I thought the recommendation, at least for new device trees, was to
> keep it flat under a "soc"-node.
> 
> If doesn't offer any advantages why not remove instead of adding the
> ranges property which seems to grow a bit complex now?
> Of course removing it would create a lot of churn because of the
> re-indentation but at least the end result would be simpler.

The general recommendation is to have the DT structure resemble
the hardware as closely as possible. If the chip has a clear
hierarchy and you know it, then it's best to describe it that way.

The reason for having a single 'soc' node in a lot of the modern
dtsi files is that either it's not documented, or they use AXI
'buses' that are not really hierarchical but are point-to-point
connections.

	Arnd
