From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 23 Jul 2018 23:47:57 +0300
Subject: [PATCH 00/12] i2c: quirks: add zero length checks and update
 drivers
In-Reply-To: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Message-ID: <CAHp75VcAzAtV0+Eu8TGPnrxSpAnPOXU9mvpeO1SaoBO3Rx=wRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 11:26 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> I had this idea for quite some time on my todo list but a soon to be
> implemented refactoring in the i2c-rcar driver now finally made me do it. Add a
> 'can't do 0 length messages' quirk to the quirk infrastructure for and remove
> the manual handling from the drivers. This makes the quirk much more visible.
> (Quite some prominent vendors in that list) We also have a centralized place to
> handle updates to the quirk detection if that is ever needed.
>
> I have tested this with the i2c-rcar and i2c-sh_mobile driver on a Renesas
> SalvatorXS board equipped with M3-N (r8a77965).
>
> A git branch can be found here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirk-no-zero-len
>
> Looking forward to comments, reviews, tests...

Thanks!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for patches 1 and 2.

>
> Thanks,
>
>    Wolfram
>
> Wolfram Sang (12):
>   i2c: quirks: add zero length checks
>   i2c: designware-master: use core to detect 'no zero length' quirk
>   i2c: mxs: use core to detect 'no zero length' quirk
>   i2c: omap: use core to detect 'no zero length' quirk
>   i2c: pmcmsp: use core to detect 'no zero length' quirk
>   i2c: qup: use core to detect 'no zero length' quirk
>   i2c: stu300: use core to detect 'no zero length' quirk
>   i2c: tegra: use core to detect 'no zero length' quirk
>   i2c: zx2967: use core to detect 'no zero length' quirk
>   i2c: rcar: use core to detect 'no zero length' quirk
>   i2c: xlr: use core to detect 'no zero length' quirk
>   i2c: sh_mobile: use core to detect 'no zero length read' quirk
>
>  drivers/i2c/busses/i2c-designware-master.c | 12 +++++-------
>  drivers/i2c/busses/i2c-mxs.c               |  8 +++++---
>  drivers/i2c/busses/i2c-omap.c              |  8 +++++---
>  drivers/i2c/busses/i2c-pmcmsp.c            | 17 +----------------
>  drivers/i2c/busses/i2c-qup.c               | 14 ++++++--------
>  drivers/i2c/busses/i2c-rcar.c              | 13 ++++++-------
>  drivers/i2c/busses/i2c-sh_mobile.c         | 10 +++++-----
>  drivers/i2c/busses/i2c-stu300.c            | 12 ++++++------
>  drivers/i2c/busses/i2c-tegra.c             |  4 +---
>  drivers/i2c/busses/i2c-xlr.c               | 11 +++++------
>  drivers/i2c/busses/i2c-zx2967.c            |  8 +++++---
>  drivers/i2c/i2c-core-base.c                |  6 ++++++
>  include/linux/i2c.h                        |  4 ++++
>  13 files changed, 60 insertions(+), 67 deletions(-)
>
> --
> 2.11.0
>



-- 
With Best Regards,
Andy Shevchenko
