From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 17 Jan 2011 08:47:20 -0700
Subject: [PATCH v3 0/6] OMAP: McSPI: Hwmod adaptation + runtime conversion
In-Reply-To: <32036.10.24.255.18.1295274181.squirrel@dbdmail.itg.ti.com>
References: <32036.10.24.255.18.1295274181.squirrel@dbdmail.itg.ti.com>
Message-ID: <AANLkTinOg3aPQrX+rp=UOf4UcMw2CVA=6COgfGpRkVm0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 7:23 AM, Govindraj.R <govindraj.raja@ti.com> wrote:
> Changes invloves:
> ----------------
> 1) Addition of hwmod data for omap2/3/4.
> 2) McSPI driver hwmod adaptation with cleanup of base address
> ? macros and using omap-device API's.
> 3) Runtime Conversion of McSPI driver.
>
> Changes from v2:
> ---------------
> 1) Fixing minor comments and adding ack from Grant Likely.
> ? ? ? ?https://patchwork.kernel.org/patch/371321/
> ? ? ? ?https://patchwork.kernel.org/patch/371331/

Hi Govindraj,

My comment still stands that it looks like a lot of duplicate data is
being generated, which makes this patch set larger than it appears to
need to be, but those files aren't in a directory that I maintain so
it's not my call.  :-)

Tony, I'm okay with your merging this series through your tree.

g.

>
> Changes from v1:
> ---------------
> 1) Fixing patch 5/5 comments for hwmod+runtime
> ?Split the patch 5/5 to hwmod adaptation
> ?and then runtime conversion
> ?http://www.mail-archive.com/linux-omap at vger.kernel.org/msg33387.html
>
> Testing Updates:
> ----------------
> Was tested using data transfer test module available at:
> http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=blob;f=mcspi/test_code/
> utils/mcspi_modules/omap_mcspi_datatest.c;
> h=e42ec10c5c844abdde6a7175a268b379fbbdb655;
> hb=5d9a755d50e58de861c5e8991f2f607bc49b5dc3
> This test basically involves MISO <--> MOSI lines looped and data transfer test
> done using the above test module.
> System wide suspend and ret/off counts observation, ensured that no behavioral
> difference with and without this patch series.
>
> Charulatha V (1):
> ?OMAP: devices: Modify McSPI device to adapt to hwmod framework
>
> Govindraj.R (5):
> ?OMAP2420: hwmod data: Add McSPI
> ?OMAP2430: hwmod data: Add McSPI
> ?OMAP3: hwmod data: Add McSPI
> ?OMAP4: hwmod data: Add McSPI
> ?OMAP: runtime: McSPI driver runtime conversion
>
> ?arch/arm/mach-omap2/devices.c ? ? ? ? ? ? ?| ?187 ++++---------------
> ?arch/arm/mach-omap2/omap_hwmod_2420_data.c | ?156 ++++++++++++++++
> ?arch/arm/mach-omap2/omap_hwmod_2430_data.c | ?219 ++++++++++++++++++++++
> ?arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | ?280 ++++++++++++++++++++++++++++
> ?arch/arm/mach-omap2/omap_hwmod_44xx_data.c | ?266 ++++++++++++++++++++++++++
> ?arch/arm/plat-omap/include/plat/mcspi.h ? ?| ? 11 +
> ?drivers/spi/omap2_mcspi.c ? ? ? ? ? ? ? ? ?| ?224 +++++++---------------
> ?7 files changed, 1043 insertions(+), 300 deletions(-)
>
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
