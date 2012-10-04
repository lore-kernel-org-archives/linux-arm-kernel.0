From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Thu, 04 Oct 2012 21:40:59 +0900
Subject: [PATCH 03/12] mmc: dw_mmc: fix building exynos driver as a module
In-Reply-To: <CAFbHwiRGnhEf-3XJJJPrHwmQRj_YE2kCZaGURHDQcu=cj0zSHw@mail.gmail.com>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-4-git-send-email-arnd@arndb.de>
 <CAFbHwiRGnhEf-3XJJJPrHwmQRj_YE2kCZaGURHDQcu=cj0zSHw@mail.gmail.com>
Message-ID: <001d01cda22d$81a3b4f0$84eb1ed0$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Monday, October 01, 2012, Will Newton <will.newton@gmail.com> wrote:
> On Fri, Sep 28, 2012 at 10:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The MODULE_DEVICE_TABLE() entry in the dw_mmc_exynos driver
> > points to the wrong symbol which results in a link error
> > when building as a loadable module.
> >
> > Further, we get a warning about the driver_data being
> > marked constant, which requires annotating a few pointers
> > as const.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: Thomas Abraham <thomas.abraham@linaro.org>
> > Cc: Will Newton <will.newton@imgtec.com>
> > Cc: Jaehoon Chung <jh80.chung@samsung.com>
> > Cc: Seungwon Jeon <tgih.jun@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: linux-mmc at vger.kernel.org
> > ---
> >  drivers/mmc/host/dw_mmc-exynos.c |    4 ++--
> >  drivers/mmc/host/dw_mmc-pltfm.c  |    2 +-
> >  drivers/mmc/host/dw_mmc-pltfm.h  |    2 +-
> >  drivers/mmc/host/dw_mmc.c        |    2 +-
> >  include/linux/mmc/dw_mmc.h       |    2 +-
> >  5 files changed, 6 insertions(+), 6 deletions(-)
> 
> This looks ok to me, but I'll let one of the Exynos guys ack those
> specific changes as I don't have the hardware.
> 
> There's already a patch for the dev_info warning in dw_mmc.c frm
> Seungwon Jeon, and it seems to me like a separate change but I don't
> really mind how it gets merged.

Looks good to me.
I don't mind it about including 'dev_info warning'.

Acked-by: Seungwon Jeon<tgih.jun@samsung.com>

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
