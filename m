From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 May 2017 13:40:22 +0100
Subject: [PATCH 1/2] arm64: marvell: dts: fill MachiatoBin board
 description
In-Reply-To: <20170516143446.4a25a306@free-electrons.com>
References: <1494890913-8360-1-git-send-email-mw@semihalf.com>
 <1494890913-8360-2-git-send-email-mw@semihalf.com>
 <20170516143446.4a25a306@free-electrons.com>
Message-ID: <20170516124022.GE22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 02:34:46PM +0200, Thomas Petazzoni wrote:
> > +&ap_sdhci0 {
> > +	status = "okay";
> > +	bus-width = <8>;
> > +	no-1-8-v;
> > +	non-removable;
> > +};
> > +
> > +&cpm_sdhci0 {
> > +	status = "okay";
> > +	bus-width = <4>;
> > +	no-1-8-v;
> > +	non-removable;
> > +};
> 
> Same comment. Also, are they both really non-removable? I have a uSD
> card connector on my MacchiatoBin board. It isn't covered by those new
> entries ?

ap_sdhci is the emmc.  cpm_sdhci is the SD slot.

Had Marcin looked at my tree, or you wait for me to post a mainline
version of my "arm64: dts: marvell: mcbin: add sdhci" patch, you'd
get an entry containing the correct description for the SD slot,
including support for the card detect signal.

However, the SD slot is rather moot at the moment, because sdhci-xenon
appears to be currently broken and non-functional, as I've already
reported.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
