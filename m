From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 29 Dec 2010 00:32:05 -0700
Subject: [PATCH 0/7 v2] OMAP: McSPI: Hwmod adaptation + runtime conversion
In-Reply-To: <AANLkTikbEUjjdy-9J_WxnhjODv5aJx0K-Z0iwbOPsYj-@mail.gmail.com>
References: <33183.10.24.255.18.1291212072.squirrel@dbdmail.itg.ti.com>
	<AANLkTikbEUjjdy-9J_WxnhjODv5aJx0K-Z0iwbOPsYj-@mail.gmail.com>
Message-ID: <20101229073205.GG8172@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 29, 2010 at 12:57:35PM +0530, Govindraj wrote:
> Hi Grant,
> 
> 
> On Wed, Dec 1, 2010 at 7:31 PM, Govindraj.R <govindraj.raja@ti.com> wrote:
> > Changes invloves:
> > ----------------
> > 1) Addition of hwmod data for omap2/3/4.
> > 1) McSPI driver hwmod adaptation with cleanup of base address
> > ? macros and using omap-device API's.
> > 2) Runtime Conversion of McSPI driver
> 
> 
> Any comments on this patch series?
> I need your review comments or ack on
> patch 6/6 and patch 7/7.
> 
> I hope this patch series can be merged with LO
> tree with your ack.

I the process of going through my backlog at the moment.  I should be
able to get to it tomorrow.

g.

> 
> --
> Thanks
> Govindraj.R
> 
> 
> >
> > Changes from v1:
> > ---------------
> > 1) Fixing patch 5/5 comments for hwmod+runtime
> > ? Split the patch 5/5 to hwmod adaptation
> > ? and then runtime conversion
> > ? http://www.mail-archive.com/linux-omap at vger.kernel.org/msg33387.html
> >
> > Testing Updates:
> > ----------------
> > Was tested using data transfer test module available at:
> > http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=blob;f=mcspi/test_code/
> > utils/mcspi_modules/omap_mcspi_datatest.c;
> > h=e42ec10c5c844abdde6a7175a268b379fbbdb655;
> > hb=5d9a755d50e58de861c5e8991f2f607bc49b5dc3
> >
> > System wide suspend and ret/off counts observation,
> > ensured that no behavioral difference with and without
> > this patch series.
> >
> > Benoit Cousson (1):
> > ?OMAP4: hwmod data: Add McSPI
> >
> > Charulatha V (5):
> > ?OMAP2420: hwmod data: Add McSPI
> > ?OMAP2430: hwmod data: Add McSPI
> > ?OMAP3: hwmod data: Add McSPI
> > ?OMAP3: clocks: Update clock domain name for mcspi fck
> > ?OMAP: devices: Modify McSPI device to adapt to hwmod framework
> >
> > Govindraj.R (1):
> > ?OMAP: runtime: McSPI driver runtime conversion
> >
> > ?arch/arm/mach-omap2/clock3xxx_data.c ? ? ? | ? ?4 +
> > ?arch/arm/mach-omap2/devices.c ? ? ? ? ? ? ?| ?189 ++++---------------
> > ?arch/arm/mach-omap2/omap_hwmod_2420_data.c | ?156 ++++++++++++++++
> > ?arch/arm/mach-omap2/omap_hwmod_2430_data.c | ?219 ++++++++++++++++++++++
> > ?arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | ?280 ++++++++++++++++++++++++++++
> > ?arch/arm/mach-omap2/omap_hwmod_44xx_data.c | ?267 ++++++++++++++++++++++++++
> > ?arch/arm/plat-omap/include/plat/mcspi.h ? ?| ? 11 +
> > ?drivers/spi/omap2_mcspi.c ? ? ? ? ? ? ? ? ?| ?225 +++++++---------------
> > ?8 files changed, 1051 insertions(+), 300 deletions(-)
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> 
> -- 
> ---
> Regards,
> Govindraj.R
