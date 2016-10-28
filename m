From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 28 Oct 2016 12:37:28 -0300
Subject: specifying order of /dev/mmcblk devices via device-tree?
In-Reply-To: <CAJ+vNU1g8nQedd06LeaD10YWUQ_UmdRToUMFKaTNT1aNY56b0g@mail.gmail.com>
References: <CAJ+vNU1g8nQedd06LeaD10YWUQ_UmdRToUMFKaTNT1aNY56b0g@mail.gmail.com>
Message-ID: <CABxcv=mSBRmXkW0w9iSQ5JMQoW5cgiTvkgkgGA7AyyZNQ_ES7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tim,

On Fri, Oct 28, 2016 at 12:23 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> Greetings,
>
> I have an IMX6 board that has the following:
> sdhc1: mmc0: sdio radio
> sdhc2: mmc1: /dev/mmcblk1: microSD connector
> sdhc3: mmc2: /dev/mmcblk2: on-board eMMC
>
> I would like to have sdhc3 registered as /dev/mmcblk0 and sdhc2
> registered as /dev/mmcblk1 so that permanent storage is the first
> mmcblk device as I think this is more intuitive however currently
> these get instanced in the order they appear in the imx6qdl.dtsi
> device-tree configuration and are not able to be mapped the way I want
> them in my dts file.
>

One should not rely on a specific MMC block device numbering, since
this could change. Look at commit 9aaf3437aa72 ("mmc: block: Use the
mmc host device index as the mmcblk device index").

> Is there a way, or if not is there a desire for a way, to specify the
> order of /dev/mmcblk devices via device-tree?
>

There was an attempt to use aliasses for this but got nacked:

https://lkml.org/lkml/2016/4/29/610

As Fabio said, you should either use UUID or labels instead:

https://wiki.archlinux.org/index.php/persistent_block_device_naming

> Regards,
>
> Tim
>

Best regards,
Javier
