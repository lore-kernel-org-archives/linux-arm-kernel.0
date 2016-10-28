From: tharvey@gateworks.com (Tim Harvey)
Date: Fri, 28 Oct 2016 08:23:04 -0700
Subject: specifying order of /dev/mmcblk devices via device-tree?
Message-ID: <CAJ+vNU1g8nQedd06LeaD10YWUQ_UmdRToUMFKaTNT1aNY56b0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

I have an IMX6 board that has the following:
sdhc1: mmc0: sdio radio
sdhc2: mmc1: /dev/mmcblk1: microSD connector
sdhc3: mmc2: /dev/mmcblk2: on-board eMMC

I would like to have sdhc3 registered as /dev/mmcblk0 and sdhc2
registered as /dev/mmcblk1 so that permanent storage is the first
mmcblk device as I think this is more intuitive however currently
these get instanced in the order they appear in the imx6qdl.dtsi
device-tree configuration and are not able to be mapped the way I want
them in my dts file.

Is there a way, or if not is there a desire for a way, to specify the
order of /dev/mmcblk devices via device-tree?

Regards,

Tim
