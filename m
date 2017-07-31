From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 31 Jul 2017 14:26:16 +0200
Subject: [PATCH 0/3] net-next: stmmac: support future possible different
 internal phy mode
In-Reply-To: <CAGb2v6626KDmww5u_-ogMJHgfdxTHQLCnUF4bmcUt35f2JJgLg@mail.gmail.com>
References: <20170728092818.23419-1-clabbe.montjoie@gmail.com>
 <20170728135544.GD32230@lunn.ch> <20170728142508.GA7221@Red>
 <20170728143600.GB2132@lunn.ch> <20170728144424.GB7221@Red>
 <f8fe754c-8b46-a9f6-4020-f7db6c985773@gmail.com>
 <20170729064815.GA2024@Red>
 <CAGb2v6626KDmww5u_-ogMJHgfdxTHQLCnUF4bmcUt35f2JJgLg@mail.gmail.com>
Message-ID: <20170731122616.GA7181@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 08:19:40PM +0800, Chen-Yu Tsai wrote:
> On Sat, Jul 29, 2017 at 2:48 PM, Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> > On Fri, Jul 28, 2017 at 10:54:30AM -0700, Florian Fainelli wrote:
> >> On 07/28/2017 07:44 AM, Corentin Labbe wrote:
> >> > On Fri, Jul 28, 2017 at 04:36:00PM +0200, Andrew Lunn wrote:
> >> >>>> I've probably asked this before: Does the internal PHY use a different
> >> >>>> PHY ID in registers 2 and 3?
> >> >>>>
> >> >>>
> >> >>> yes
> >> >>>
> >> >>> reg2: 0x0044
> >> >>> reg3: 0X1500
> >> >
> >> > Copy/paste error, its 1400
> >> >
> >> >>
> >> >> So this is not about loading the correct PHY driver. You can already
> >> >> do this based on the PHY IDs...
> >> >>
> >> >> This is about selecting which PHY to use. Internal or External?
> >> >>
> >> >>      Andrew
> >> >
> >> > It is too late when we know the PHY ID.
> >>
> >> > We need to set a syscon for choosing external/internal PHY.
> >> > So we can rely only on DT.
> >>
> >> Since the Device Tree needs to be correct to identify which PHY to use
> >> (internal or external), if you use the standard compatible string for
> >> the PHY that contains its OUI, e.g:
> >>
> >> compatible = "ethernet-phy-id0044.1400", "ethernet-phy-ieee802.3-c22"
> >>
> >> then you can have your Ethernet MAC identify whether this is an internal
> >> PHY by having a list of compatible strings to match against.
> >
> > So basicly, I replace sun8i-h3-ephy by ethernet-phy-id0044.1400 and it is good ?
> 
> IIRC you mentioned some time ago the PHY in the AC200 also has this ID?
> Do you remember if this is true?

Yes it's certainly a AC200 PHY in the H3.

> 
> If someone were crazy enough to hook that up to the H3, then we still
> wouldn't be able to tell if it's the internal or external one.
> 

Why someone would put the same external PHY than the internal one ?
Yeah its totally crazy and I think we are safe by saying "it's not supported".

Regards
