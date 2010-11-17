From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed, 17 Nov 2010 21:38:44 +0800
Subject: [PATCH 1/3] OMAP: DSS2: Add generic DPI panel display driver
In-Reply-To: <1289997841.26444.21.camel@tubuntu>
References: <1289960640-8782-1-git-send-email-bryan.wu@canonical.com>
	<1289960640-8782-2-git-send-email-bryan.wu@canonical.com>
	<1289997841.26444.21.camel@tubuntu>
Message-ID: <AANLkTi=yQwo0AATr=X2oNAvsU1Y3+RSEu8oUOLym6-u9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 17, 2010 at 8:44 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> On Wed, 2010-11-17 at 10:23 +0800, ext Bryan Wu wrote:
>> Generic DPI panel driver includes the driver and 4 similar panel configurations. It
>> will match the panel name which is passed from platform data and setup the
>> right configurations.
>>
>> With generic DPI panel driver, we can remove those 4 duplicated panel display
>> drivers. In the future, it is simple for us just add new panel configuration
>> date in panel-generic-dpi.c to support new display panel.
>>
>> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>> ---
>> ?.../arm/plat-omap/include/plat/panel-generic-dpi.h | ? 37 ++
>> ?drivers/video/omap2/displays/Kconfig ? ? ? ? ? ? ? | ? ?8 +
>> ?drivers/video/omap2/displays/Makefile ? ? ? ? ? ? ?| ? ?1 +
>> ?drivers/video/omap2/displays/panel-generic-dpi.c ? | ?348 ++++++++++++++++++++
>> ?4 files changed, 394 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/plat-omap/include/plat/panel-generic-dpi.h
>> ?create mode 100644 drivers/video/omap2/displays/panel-generic-dpi.c
>>
>
[snip]

>> +
>> +static void generic_dpi_panel_remove(struct omap_dss_device *dssdev)
>> +{
>> +}
>
> You need to free the drv_data here.
>
> Perhaps this will be the last fix =).
>

My bad, I just sent out the 8th version for review. Moreover, I think
in panel-taal.c it also misses call dev_set_drvdata(&dssdev->dev,
NULL); after we kfree(td) in taal_remove().

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
