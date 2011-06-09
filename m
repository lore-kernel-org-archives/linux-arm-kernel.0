From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 9 Jun 2011 08:57:39 -0700
Subject: [PATCH] ARM: tegra/harmony: enable USB host ports
In-Reply-To: <BANLkTikRZw+OjUit=uLpHYS1KkPeM2FbEw@mail.gmail.com>
References: <1307528018-14454-1-git-send-email-marc.zyngier@arm.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498E1CDC5@HQMAIL01.nvidia.com>
	<4DEFADCB.90805@arm.com>
	<BANLkTikRZw+OjUit=uLpHYS1KkPeM2FbEw@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498E1CFA6@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Rapoport wrote at Thursday, June 09, 2011 12:53 AM:
> On Wed, Jun 8, 2011 at 8:13 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >
> > > I'm not sure if that platform data is appropriate for tegra_ehci1_device;
> > > the ChromeOS kernel doesn't enable that port.
> >
> > There's probably some kind of GPIO trickery involved to reset the
> > port...
> 
> I don't think it's possible to enable port 1 in host mode on
> harmony... As far as I remember, port 1 is routed to mini-B connector
> and there's nothing that would supply Vbus in the host mode...

Yes, looking at the schematic, I don't think I can see anything to drive
5v onto that connector, just detect whether it's there. For the other 3
USB ports, there's clearly something to drive 5v based on a signal from
the LAN/USB hub chip.

-- 
nvpublic
