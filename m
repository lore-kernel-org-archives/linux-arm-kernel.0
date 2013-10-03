From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 3 Oct 2013 12:28:01 +0200
Subject: Armada XP doesn't boot in v3.12-rc3
In-Reply-To: <CAFJTrDsiOfG1rNWo3OXtzdcquP8kdS+_x2YYELOQDH96SLGm_A@mail.gmail.com>
References: <CAFJTrDvNYa2g-TFPjii5WpCgnX8kc8r9v3+jzL7gkHCwRV-obg@mail.gmail.com>
 <20131002124320.GL31178@titan.lakedaemon.net>
 <CAFJTrDsTmSzFEX7XVqnw4=vYiBdqNeLDQuWFotSEZqGsFxT9sA@mail.gmail.com>
 <20131002202547.GA10645@localhost>
 <CAFJTrDsiOfG1rNWo3OXtzdcquP8kdS+_x2YYELOQDH96SLGm_A@mail.gmail.com>
Message-ID: <20131003122801.7f72bc26@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Matthew Minter,

On Thu, 3 Oct 2013 10:41:07 +0100, Matthew Minter wrote:

> It seems the latest build of "for-next" from
> git://git.infradead.org/linux-mvebu.git works the charm.
> For reference I have a version of uBoot that came with the board, I am
> reluctant to reflash it as I would then have no way of recovering and
> it has not seemed to cause any issues anyway. (the only drawback is
> that it seems to prefer to appended dtb image and not explicit
> passing).

Don't worry: there is a way of recovering, through the UART, using the
kwboot tool that Sebastian and I have added to the Barebox sources.
Sebastian and I have already been able to run Barebox (a different
bootloader) on Armada 370 and Armada XP platforms, though the support
is limited to the serial port for the moment, so it's quite useless for
any practical usage.

As of today, there is no Armada 370/XP support in the mainline U-Boot,
and Marvell has not yet released an U-Boot version that has Device Tree
support, so we're stuck with appended DTB for now. However, Marvell is
working on a DT-capable version of their U-Boot, which should arrive at
some point in the future.

> The version is as follows but is likely not useful as it seems to be a
> build customised for the hardware, it does support uImages and the new
> format however:
> 
> U-Boot 2011.12-00036-g664db9a-dirty (Oct 16 2012 - 14:12:23) Marvell
> version: 2012_Q4.1

It is useful for us, as we can compare it to the U-Boot version we're
using, and we also have the possibility of upgrading our U-Boot to a
different version if needed.

> I am still working through some small driver issues (trying to mount
> various SSDs) but the early boot failure is resolved with those
> patches and the default configuration (plus early printk).

Great. Regarding SSDs, we successfully tested the SATA support on
Armada XP GP with hard drives, and the SATA support was also
successfully tested on OpenBlocks AX3-4 (which has an Armada XP) using
a SSD.

> Thank you all so much for the help, I think this board is now working
> fine but will report any other issues I come across later.

Sure!

As soon as the relevant fixes of mvebu/for-next hit mainline, you'll be
able to switch back to using the mainline kernel. Note that you can
also use 3.11 for the moment, which should also work on this platform.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
