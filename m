From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 9 Dec 2011 22:57:18 +0100
Subject: [PATCH v2] ARM: S3C64XX: Implement basic power domain support
In-Reply-To: <00a701ccb605$9ba84650$d2f8d2f0$%kim@samsung.com>
References: <1323306483-27132-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112082355.11249.rjw@sisk.pl>
 <00a701ccb605$9ba84650$d2f8d2f0$%kim@samsung.com>
Message-ID: <201112092257.18319.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 09, 2011, Kukjin Kim wrote:
> 
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw at sisk.pl]
> > Sent: Friday, December 09, 2011 7:55 AM
> > To: Mark Brown
> > Cc: Kukjin Kim; linux-arm-kernel at lists.infradead.org; linux-samsung-
> > soc at vger.kernel.org
> > Subject: Re: [PATCH v2] ARM: S3C64XX: Implement basic power domain support
> > 
> > On Thursday, December 08, 2011, Mark Brown wrote:
> > > The S3C64xx SoCs contain a set of gateable power domains which can be
> > > enabled and disabled at runtime in order to save power.  Use the generic
> > > power domain code to implement support for these in software, enabling
> > > runtime control of most domains:
> > >
> > >  - ETM (not supported in mainline).
> > >  - Domain G: 3D acceleration (no mainline support).
> > >  - Domain V: MFC (no mainline support).
> > >  - Domain I: JPEG and camera interface (no mainline support).
> > >  - Domain P: 2D acceleration, TV encoder and scaler (no mainline
> support)
> > >  - Domain S: Security (no mainline support).
> > >  - Domain F: LCD (driver already uses runtime PM), post processing and
> > >    rotation (no mainline support).
> > >
> > > The IROM domain is marked as always enabled as we should arrange for it
> > > to be enabled when we suspend which will need a bit more work.
> > >
> > > Due to all the conditional device registration that the platform does
> > > wrap s3c_pm_init() with s3c64xx_pm_init() which actually puts the device
> > > into the power domain after the machines have registered, looking for
> > > platform data to tell if the device was registered. Since currently only
> > > Cragganmore actually sets up PM that is the only machine updated.
> > >
> > > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > > Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> > 
> > Applied to linux-pm/linux-next.
> > 
> Hi Rafael,
> 
> As I said, I need topic branch for merging into my tree to avoid conflicts,
> but I couldn't find any branch for this.

And as I said, I'll put those patches into the pm-domains branch of my tree
shortly (most likely later today), which I think is the topic branch you need.

Thanks,
Rafael
