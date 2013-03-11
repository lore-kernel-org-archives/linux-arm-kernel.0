From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Mar 2013 09:20:41 -0700
Subject: Dead mappings and drivers in MTD
In-Reply-To: <1363016099.3348.47.camel@sauron.fi.intel.com>
References: <1363016099.3348.47.camel@sauron.fi.intel.com>
Message-ID: <CAOesGMhy6YceRr3T4ZALhYeSQfEuASO+ajJy1Htwws=OMtvrTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 11, 2013 at 8:34 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> Hi MTD folks,
>
> we have huge amount of drivers, espacially mapping drives in
> 'drivers/mtd', and for sure may of them are for ancient devices which
> are long dead and not supported by modern kernels anyway. I would like
> to do a small clean-up. It is difficult to judge which ones are dead for
> me, so I am asking the community to help. Thanks!
>
> There are few easy cases - some drivers depend on Kconfig symbols which
> are not defined anywhere - I guess these are clear candidates for
> removal. For example this one:
>
> config MTD_DBOX2
>         tristate "CFI Flash device mapped on D-Box2"
>         depends on DBOX2 && MTD_CFI_INTELSTD && MTD_CFI_INTELEXT && MTD_CFI_AMDSTD
>         help
>           This enables access routines for the flash chips on the Nokia/Sagem
>           D-Box 2 board. If you have one of these boards and would like to use
>
> Grepping for "DBOX2" gives nothing.

In 2.6.14, it dropped two dependencies that used to be there for PPC32
and 8xx. There still was no DBOX2 symbol to fulfill that dependency
back then.

Take it out, if someone finds a user later on it can always be
reverted. Seems very very unlikely in this case.


-Olof
