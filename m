From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 28 Oct 2016 13:33:21 -0200
Subject: specifying order of /dev/mmcblk devices via device-tree?
In-Reply-To: <CAJ+vNU1g8nQedd06LeaD10YWUQ_UmdRToUMFKaTNT1aNY56b0g@mail.gmail.com>
References: <CAJ+vNU1g8nQedd06LeaD10YWUQ_UmdRToUMFKaTNT1aNY56b0g@mail.gmail.com>
Message-ID: <CAOMZO5Az1YpL1VUcc_ox=6h4_3hdV1Akt_9bD3=2ftay2_JUrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On Fri, Oct 28, 2016 at 1:23 PM, Tim Harvey <tharvey@gateworks.com> wrote:
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
> Is there a way, or if not is there a desire for a way, to specify the
> order of /dev/mmcblk devices via device-tree?

You could use UUID to specify the rootfs location on your board.

Please check:
http://git.denx.de/?p=u-boot.git;a=commit;h=ca4f338e2efece5196eb2178e5f7d07be828da6e
