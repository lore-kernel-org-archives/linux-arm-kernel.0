From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 17 Jan 2012 11:50:33 -0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <CACRpkdYmxQd7aaRhs+xc5nizC7OjwRzsduq-28kVTLjhTGjVZw@mail.gmail.com>
References: <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E6B@HQMAIL01.nvidia.com>
 <20120107135445.GI4790@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A6E5@HQMAIL01.nvidia.com>
 <20120112033941.GH20968@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17801D1DCC@HQMAIL01.nvidia.com>
 <20120113034558.GA12184@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17801D1F9D@HQMAIL01.nvidia.com>
 <20120114012213.GD1810@S2101-09.ap.freescale.net>
 <CACRpkdYmxQd7aaRhs+xc5nizC7OjwRzsduq-28kVTLjhTGjVZw@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17801D230A@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Monday, January 16, 2012 9:09 AM:
> On Sat, Jan 14, 2012 at 2:22 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Fri, Jan 13, 2012 at 10:16:36AM -0800, Stephen Warren wrote:
> >> Admittedly, the wording of Linusw's actually seems to agree more with how
> >> you're interpreting what Dong said, but in that case, I don't think his
> >> reply makes sense - the whole purpose of the mux mapping table is to
> >> represent the board-specific configuration. If we're going to circumvent
> >> it, we should completely remove it from the pinctrl subsystem, rather than
> >> having some boards avoid using it by creating virtual pin groups instead.
> >>
> > IMO, it's a compromise. ?It still makes sense to have concept of
> > pingroup in pinctrl subsystem, because platforms like Tegra have
> > the HW pingroup.
> 
> I'm not able to follow this discussion, it's too much stuff here that I don't
> quite grasp :-(
> 
> The pinctrl idea of a group is defined in Documentation/pinctrl.txt:
> 
> ---------------------8<---------------------------8<-----------------------------
> 
> Pin groups
> ==========
> 
> Many controllers need to deal with groups of pins, so the pin controller
> subsystem has a mechanism for enumerating groups of pins and retrieving the
> actual enumerated pins that are part of a certain group.
> 
> For example, say that we have a group of pins dealing with an SPI interface
> on { 0, 8, 16, 24 }, and a group of pins dealing with an I2C interface on pins
> on { 24, 25 }.
...
> ---------------------8<---------------------------8<-----------------------------
> 
> 
> As you can see none of the text above claims that the group is
> about hardware-defined groups or anything like that.

Well, I guess that's true, but didn't we only add the concept of groups
to the pinctrl subsystem in order to support Tegra's HW-group-based
muxing? And irrespective of that, why would you want to define "virtual"
groups in the pinctrl driver when the whole point of the pin mux mapping
table allowing multiple entries for a device was to handle the mux-by-
pin case?

> The groups
> are just that - a group of pins, an abstract concept of a group.
> It could be drawn i UML even... maybe I'll do that for my
> ELC presentation :-)

I should ask: Who here is coming to Linaro Connect and/or ELC? I'm
Currently signed up for Linaro Connect, but not ELC. I could probably
add ELC if there was good reason.

-- 
nvpublic
