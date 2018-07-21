From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 14:47:23 -0700
Subject: [PATCH] ARM: dts: rmobile: Drop MTD partitioning from DT
In-Reply-To: <20180530101130.3566-1-marek.vasut+renesas@gmail.com>
References: <20180530101130.3566-1-marek.vasut+renesas@gmail.com>
Message-ID: <CAOesGMjmz41p5sF_xnC7gdSRNLaowXPW7Sk8HBZww_QSTvXV7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 30, 2018 at 3:11 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Drop the MTD partitioning from DT, since it does not describe HW
> and to give way to a more flexible kernel command line partition
> passing.
>
> To retain the original partitioning, assure you have enabled
> CONFIG_MTD_CMDLINE_PARTS in your kernel config and add the
> following to your kernel command line:
>
> lager:   mtdparts=spi0.0:256k(loader),4m(user),-(flash)
> stout:   mtdparts=spi0.0:512k(loader),256k(uboot),256k(uboot-env),-(flash)
> koelsch: mtdparts=spi0.0:512k(loader),5632k(user),-(flash)
> porter:  mtdparts=spi0.0:256k(loader_prg),4m(user_prg),-(flash_fs)
> wheat:   mtdparts=spi0.0:256k(loader),4m(user),-(flash)
> gose:    mtdparts=spi0.0:256k(loader),4m(user),-(flash)
> alt:     mtdparts=spi0.0:256k(loader),256k(system),-(user)
> silk:    mtdparts=spi0.0:256k(loader),4m(user),-(flash)

Having to specify on command line is such a nasty hack. I wish we
could remove that, and at the very least not add it for anything new.

You end up with user space tools trying to parse the kernel command
line to figure out what's on the flash, and other really bad habits.
:(

I'd strongly advice you to keep this in the board files, unless you
have an actual real motivation for changing it. This patch does not
provide one.


-Olof
