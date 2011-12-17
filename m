From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Dec 2011 16:24:09 -0800
Subject: [GIT PULL] ARM: OMAP: I2C: prepare to use hwmod reset in driver
In-Reply-To: <alpine.DEB.2.00.1112161357250.12660@utopia.booyaka.com>
References: <alpine.DEB.2.00.1112160254320.12660@utopia.booyaka.com>
 <20111216195002.GL32251@atomide.com>
 <alpine.DEB.2.00.1112161314180.12660@utopia.booyaka.com>
 <20111216204123.GM32251@atomide.com>
 <alpine.DEB.2.00.1112161357250.12660@utopia.booyaka.com>
Message-ID: <20111217002409.GB6464@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111216 12:27]:
> Hi
> 
> On Fri, 16 Dec 2011, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [111216 11:45]:
> > > On Fri, 16 Dec 2011, Tony Lindgren wrote:
> > > 
> > > > * Paul Walmsley <paul@pwsan.com> [111216 01:24]:
> > > >
> > > > > Shubhrajyoti D (2):
> > > > >       ARM: OMAP: omap_device: add omap_device_reset to reset all the hwmods in the device
> > > > >       ARM: OMAP: I2C: Reset support
> > > > > 
> > > > Can you please update shi to leave out the extra callback
> > > > function int (*device_reset) (struct device *dev) as I'd
> > > > rather see that happen with pm_runtime calls?
> > > 
> > > What PM runtime call is used to reset a device?
> > 
> > Hmm how about pm_runtime_disable? Or do we need a new
> > call for reset?

Meanwhile as Paul pointed out, we still need the device_reset
pointer, so pulling in this series into i2c branch.
 
> Looking at the last few hunks of:
> 
> http://marc.info/?l=linux-omap&m=132377389204328&w=2
> 
> it appears to me that the driver needs to reset the device while it's 
> still active & powered on, etc.
> 
> Shubhrajyoti, care to comment further?
> 
> 
> - Paul
