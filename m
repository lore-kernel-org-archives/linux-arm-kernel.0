From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 2 Mar 2018 23:04:45 +0100
Subject: [PATCH 2/2] ARM: dts: armada388-clearfog: add SFP module support
In-Reply-To: <20180302220215.GC9418@n2100.armlinux.org.uk>
References: <20180227160135.GU9418@n2100.armlinux.org.uk>
 <E1eqhha-0004l3-Rd@rmk-PC.armlinux.org.uk>
 <20180302215614.GD25189@lunn.ch>
 <20180302220215.GC9418@n2100.armlinux.org.uk>
Message-ID: <20180302220445.GF25189@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 10:02:15PM +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 02, 2018 at 10:56:14PM +0100, Andrew Lunn wrote:
> > On Tue, Feb 27, 2018 at 04:02:02PM +0000, Russell King wrote:
> > > Add SFP module support for Clearfog using the SFP phylink support.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Tested-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > Using a RoboFiber SFP module, connected to a media converter. Link
> > up/down detected.
> 
> ethtool -m should also work.

Yes, it does. Sorry, should of said that.

root at clearfog:~# ethtool -m eth1
        Identifier                                : 0x03 (SFP)
        Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
        Connector                                 : 0x07 (LC)
        Transceiver codes                         : 0x00 0x00 0x00 0x01 0x00 0x00 0x00 0x00
        Transceiver type                          : Ethernet: 1000BASE-SX
        Encoding                                  : 0x01 (8B/10B)
        BR, Nominal                               : 1300MBd
        Rate identifier                           : 0x00 (unspecified)
        Length (SMF,km)                           : 0km
        Length (SMF)                              : 0m
        Length (50um)                             : 550m
        Length (62.5um)                           : 270m
        Length (Copper)                           : 0m
        Length (OM3)                              : 0m
        Laser wavelength                          : 850nm
        Vendor name                               : OEM             
        Vendor OUI                                : 20:20:20
        Vendor PN                                 : SFP-7000-85     
        Vendor rev                                : 11.0
        Optical diagnostics support               : Yes
        Laser bias current                        : 45.512 mA
        Laser output power                        : 0.2861 mW / -5.43 dBm
        Receiver signal average optical power     : 0.2749 mW / -5.61 dBm
        Module temperature                        : 25.72 degrees C / 78.29 degrees F
        Module voltage                            : 3.2856 V
...

	Andrew
