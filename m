From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 14 Nov 2013 14:22:51 +0100
Subject: [PATCH] ARM: shmobile: r7s72100 GPIO DT nodes for GPIO RZ
In-Reply-To: <CANqRtoTr3fepq3+UF3715Ece+LqWzNLF6aLWA1w_yRu0nO1nNA@mail.gmail.com>
References: <20131113233927.1559.99212.sendpatchset@w520>
 <5286379.6UUfAggTmV@avalon>
 <CANqRtoTr3fepq3+UF3715Ece+LqWzNLF6aLWA1w_yRu0nO1nNA@mail.gmail.com>
Message-ID: <4074316.z3ls6AxRyh@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Thursday 14 November 2013 17:39:08 Magnus Damm wrote:
> On Thu, Nov 14, 2013 at 8:57 AM, Laurent Pinchart wrote:
> > On Thursday 14 November 2013 08:39:27 Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >> 
> >> Add a total of 13 GPIO DT device nodes for r7s72100.
> >> 
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >> ---
> >> 
> >>  arch/arm/boot/dts/r7s72100.dtsi |  131 +++++++++++++++++++++++++++++++++
> >>  1 file changed, 131 insertions(+)
> >> 
> >> --- 0001/arch/arm/boot/dts/r7s72100.dtsi
> >> +++ work/arch/arm/boot/dts/r7s72100.dtsi      2013-11-13
> >> 22:33:56.000000000 +0900
> >> @@ -14,6 +14,22 @@
> >>       #address-cells = <1>;
> >>       #size-cells = <1>;
> >> 
> >> +     aliases {
> >> +             gpio0 = &p0;
> >> +             gpio1 = &p1;
> >> +             gpio2 = &p2;
> >> +             gpio3 = &p3;
> >> +             gpio4 = &p4;
> >> +             gpio5 = &p5;
> >> +             gpio6 = &p6;
> >> +             gpio7 = &p7;
> >> +             gpio8 = &p8;
> >> +             gpio9 = &p9;
> >> +             gpio10 = &p10;
> >> +             gpio11 = &p11;
> > 
> > I would have called the phandles gpio[0-9]* instead of p[0-9]*. Shorter
> > names may clash with something else later.
> 
> I see. In this case the p0-p11 names match with the datasheet. Would
> you prefer "port0" to match "Port 0" in the data sheet instead?
> 
> >> +             gpio12 = &jp0;
> > 
> > What is this special GPIO controller instance ?
> 
> It is called  "jp0" or "JTAG Port 0" in the data sheet. It's a
> read-only port for some pins associated with the JTAG connector.
> 
> Of course, it is possible to use gpio0 -> gpio12 but that is IMO more
> difficult to use since those won't match with the data sheet or
> schematics.

Would port0 -> port 11 and jtag-port be fine ?

-- 
Regards,

Laurent Pinchart
