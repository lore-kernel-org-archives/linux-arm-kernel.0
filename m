From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Jan 2016 09:14:21 +0000
Subject: [PATCH] mmc: host: omap_hsmmc: add a verbose print to enable
 CONFIG_REGULATOR_PBIAS
In-Reply-To: <20160114224025.GA26988@earth>
References: <1452762920-2588-1-git-send-email-kishon@ti.com>
 <20160114120706.GA12774@earth>
 <20160114172549.GC5783@n2100.arm.linux.org.uk>
 <20160114224025.GA26988@earth>
Message-ID: <20160115091421.GD5783@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 11:40:25PM +0100, Sebastian Reichel wrote:
> On Thu, Jan 14, 2016 at 05:25:49PM +0000, Russell King - ARM Linux wrote:
> > There are very good reasons not to do this: that will result in
> > configurations where MMC_OMAP_HS was set but without REGULATOR_PBIAS
> > ending up with MMC_OMAP_HS being disabled.  That doesn't help the
> > root problem, which is "why has the kernel boot regressed for my
> > previous working configuration?"
> > 
> > The solution proposed here adds a message to the boot which points
> > out fair and square what needs to be done to rectify the boot
> > failure.  Adding a dependency just brings up the question "where
> > has my MMC driver gone?"
> 
> The best thing would be to have no regression. Just printing a
> message means I have to build another kernel. But more importantly
> the message may not be visible by the user - e.g. if the display has
> not yet been initialized.

I agree in principle, but that's not possible here (see Tony's mails
on why the PBIAS stuff needs to be optional.)  I'd agree with changing
the Kconfig if PBIAS were a hard and fast requirement, but it isn't.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
