From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 01:20:22 +0200
Subject: [GIT PULL 3/4] ARM: imx: device tree updates for 4.1
In-Reply-To: <20150407222712.GA4543@dragon>
References: <CAAQ0ZWTPqbqk5VwWGQvJ7NbmOy58YOzK4Jv76jEPNL961tpviw@mail.gmail.com>
 <20150407222712.GA4543@dragon>
Message-ID: <201504140120.23007.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 April 2015, Shawn Guo wrote:
> On Mon, Mar 30, 2015 at 10:02:44PM +0800, Shawn Guo wrote:
> > Arnd, Olof,
> > 
> > Because of the DT ABI agreement, device tree branch should generally
> > be able to go alone without any dependencies.  But for this release,
> > i.MX community have agreed to break the old DTBs to adopt
> > stacked/hierarchy irq domains for i.MX GPC and Vybrid MSCM controller.
> > And we included a couple of branches as the merge base for this imx/dt
> > pull request, including Jason's irqchip/vybrid branch, to resolve some
> > merge conflicts and maintain the run-time dependency.
> > 
> > Jason,
> > 
> > As we talked, please keep your irqchip/vybrid branch stable.  Thanks.
> > 
> > Shawn
> > 
> > 
> > The following changes since commit c5455f708b968dc462a292ba99da0d17100461d8:
> > 
> >   Merge remote-tracking branch 'jcooper/irqchip/vybrid' into imx/dt
> > (2015-03-30 16:37:21 +0800)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> > tags/imx-dt-4.1
> > 
> > for you to fetch changes up to 8e047c120fb2ccb7b7aba8f5e9224e463f86bebc:
> > 
> >   ARM: dts: hummingboard: add sgtl5000 support for Hummingboard Pro
> > (2015-03-30 20:57:42 +0800)
> > 
> > ----------------------------------------------------------------
> > The i.MX device tree updates for 4.1:
> >  - Convert GPC controller to use stacked interrupt domains
> >  - Add power domain descriptions for i.MX6 platforms
> >  - Improve i.MX25 pin function defines
> >  - Disable PWM devices in <soc>.dtsi by default and enable it at board
> >    level dts where the device is actually available.
> >  - Define labels for SNVS RTC device to ease the board description,
> >    where an external RTC is available.
> >  - Add dr_mode host setting to all i.MX host-only USB instances
> >  - Support Miscellaneous System Control Module (MSCM) for VF610
> >  - Add initial i.MX6SL WaRP Board support
> >  - Add i.MX6SX SDB revision B board support
> >  - A bunch of imx28-apf28dev board updates, including gpio polarity
> >    correction and CAN, AUART device support.
> >  - SolidRun iMX6 platform updates: dual-license of GPLv2/X11, PWM
> >    setup, PCF8523 RTC, GPIO key and SGTL5000 audio support.
> >  - A number of random device additions for boards: SPI and CAN for
> >    vf-colibri, MAX7310 GPIO expander for imx6qdl-sabreauto and LCD
> >    support for imx25-pdk.
> > 
> > Note: Branch imx/cleanup was merged as the base to solve conflict on
> > imx25 iomux header.  Branch imx/soc was merged as the base to solve
> > conflict on arch/arm/mach-imx/gpc.c.  And Jason Cooper's irqchip/vybrid
> > branch was pulled into the base as a run-time dependency.
> > 
> > ----------------------------------------------------------------
> 
> Hi Olof,
> 
> I have seen you pulled all other 3 requests except this one.  Anything
> wrong with it?
> 

I don't know what happened with this, but I've put it into next/late
because it seemed like Olof accidentally it by mistake.

If everything goes well, we'll send it after the first batch is merged.

Olof, do you know anything about this series that I don't?

	Arnd
