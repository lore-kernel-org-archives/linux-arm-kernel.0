From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 15 Nov 2016 12:27:53 -0800
Subject: specifying order of /dev/mmcblk devices via device-tree?
In-Reply-To: <20161114190839.GS1041@n2100.armlinux.org.uk>
References: <CAJ+vNU1g8nQedd06LeaD10YWUQ_UmdRToUMFKaTNT1aNY56b0g@mail.gmail.com>
 <20161028153755.GL5806@leverpostej>
 <CAJ+vNU26tx-1bLKNpzYJ0UCeFJ-SczZOca1dYdt5mCGDxAuKTQ@mail.gmail.com>
 <20161114190839.GS1041@n2100.armlinux.org.uk>
Message-ID: <CAJ+vNU38XQBHt709S_z6Quvce6wcqLzRHFuN_bVZ_0eARa3=fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 11:08 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> So, someone merged a patch which makes mmcblk devices follow the
> host controller numbering.
>
> Now my cubox-i fails to boot correctly because the SD card in the
> _only_ SD card slot now gets called "mmcblk1" and not "mmcblk0".
>
> USDHC1 is wired to the on-microsom WiFi, and never has anything
> remotely near a SD card or eMMC present.  So, this change is
> confusing on these platforms.
>
> Moreover, this is _going_ to break SolidRun distros if people upgrade
> their kernels.
>
> It may be appropriate for eMMC, but it's not appropriate everywhere.
>
> This is a user visible _regression_ in 4.9-rc.  Whoever did this,
> please revert whatever change caused this, and next time limit it
> to only eMMC.
>
> Thanks.

I see the same thing on newer kernels, which is why I asked the
question. I didn't expect (or even want honestly) a non mmcblk0 boot
device and was looking for a way to control that via dt. Now I'm
understanding that to avoid this kind of bootloader/kernel dependence
issue I should be using UUID's to identify the boot device.

>From my testing it looks like the change your looking for occurred
some time ago and is somewhere between 4.5 and 4.6 and not a 4.9
regression specifically.

Regards,

Tim
