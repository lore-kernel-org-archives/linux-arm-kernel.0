From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Jun 2013 15:03:21 -0400
Subject: [PATCH] arm: mvebu: ensure PCIe range is propagated in the
 .dts files
In-Reply-To: <20130606181159.GN23859@titan.lakedaemon.net>
References: <1370510483-32419-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370510483-32419-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606181159.GN23859@titan.lakedaemon.net>
Message-ID: <20130606190321.GQ23859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 02:11:59PM -0400, Jason Cooper wrote:
> On Thu, Jun 06, 2013 at 11:21:23AM +0200, Thomas Petazzoni wrote:
> > The ranges DT entry needed by the PCIe controller is defined at the
> > SoC .dtsi level. However, some boards have a NOR flash, and to support
> > it, they need to override the SoC-level ranges property to add an
> > additional range. Since PCIe and NOR support came separately, some
> > boards were not properly changed to include the PCIe range in their
> > ranges property at the .dts level.
> > 
> > This commit fixes those platforms.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> 
> Can you split this in to two patches, please:
> 
> >  arch/arm/boot/dts/armada-xp-db.dts               | 1 +
> 
> one for mvebu/dt
> 
> >  arch/arm/boot/dts/armada-xp-gp.dts               | 5 +++--
> >  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 5 +++--
> 
> and one for mvebu/fixes?

Nevermind, I've got a few minutes and would like to get it in for the
last -next this week.

thx,

Jason.
