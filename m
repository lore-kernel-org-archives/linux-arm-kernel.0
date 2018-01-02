From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Jan 2018 11:38:29 +0000
Subject: [PATCH] arch: drop duplicate exports of abort()
In-Reply-To: <20180102113417.GA5078@sudip-tp>
References: <20180102103311.706364-1-arnd@arndb.de>
 <20180102113417.GA5078@sudip-tp>
Message-ID: <20180102113829.GD28752@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 11:34:45AM +0000, Sudip Mukherjee wrote:
> Hi Arnd,
> 
> On Tue, Jan 02, 2018 at 11:31:12AM +0100, Arnd Bergmann wrote:
> > We now have exports in both architecture code in in common code,
> > which causes a link failure when symbol versioning is eanbled, on
> > four architectures:
> > 
> > kernel/exit.o: In function `__crc_abort':
> > exit.c:(*ABS*+0xc0e2ec8b): multiple definition of `__crc_abort'
> > 
> > This removes the four architecture specific exports and only
> > leaves the export next to the __weak symbol.
> 
> Will it not be better to remove the abort() as they are exactly same
> like the weak function. That was the original plan we had when this
> weak function was done. Like in the attached patch..

If that was the plan, why wasn't it done - why did we end up with a
build-breaking patch merged in -mm?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
