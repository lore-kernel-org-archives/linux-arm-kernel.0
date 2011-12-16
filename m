From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Dec 2011 12:41:23 -0800
Subject: [GIT PULL] ARM: OMAP: I2C: prepare to use hwmod reset in driver
In-Reply-To: <alpine.DEB.2.00.1112161314180.12660@utopia.booyaka.com>
References: <alpine.DEB.2.00.1112160254320.12660@utopia.booyaka.com>
 <20111216195002.GL32251@atomide.com>
 <alpine.DEB.2.00.1112161314180.12660@utopia.booyaka.com>
Message-ID: <20111216204123.GM32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111216 11:45]:
> Hi
> 
> On Fri, 16 Dec 2011, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [111216 01:24]:
> > > The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:
> > > 
> > >   Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)
> > > 
> > > are available in the git repository at:
> > >   git://git.pwsan.com/linux-2.6 i2c_reset_devel_3.3
> > > 
> > > Shubhrajyoti D (2):
> > >       ARM: OMAP: omap_device: add omap_device_reset to reset all the hwmods in the device
> > >       ARM: OMAP: I2C: Reset support
> > > 
> > >  arch/arm/plat-omap/i2c.c                      |    2 ++
> > >  arch/arm/plat-omap/include/plat/omap_device.h |    1 +
> > >  arch/arm/plat-omap/omap_device.c              |   22 ++++++++++++++++++++++
> > >  include/linux/i2c-omap.h                      |    1 +
> > >  4 files changed, 26 insertions(+), 0 deletions(-)
> > 
> > Can you please update shi to leave out the extra callback
> > function int (*device_reset) (struct device *dev) as I'd
> > rather see that happen with pm_runtime calls?
> 
> What PM runtime call is used to reset a device?

Hmm how about pm_runtime_disable? Or do we need a new
call for reset?

Tony
