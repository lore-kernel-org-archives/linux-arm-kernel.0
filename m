From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Thu, 11 Jun 2015 09:37:24 +0800
Subject: [PATCH v5 3/7] mmc: mediatek: Add PM support for MMC driver
In-Reply-To: <CAPDyKFrdw6m8C6oXRRC1cxmOPda8WqrFwwuP87rDBqEehdTaTA@mail.gmail.com>
References: <1433903088-14407-1-git-send-email-chaotian.jing@mediatek.com>
 <1433903088-14407-4-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFrdw6m8C6oXRRC1cxmOPda8WqrFwwuP87rDBqEehdTaTA@mail.gmail.com>
Message-ID: <1433986644.14592.6.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-06-10 at 13:59 +0200, Ulf Hansson wrote:
> On 10 June 2015 at 04:24, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > Add PM support for Mediatek MMC driver
> > Save/restore registers when PM
> >
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 88 +++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 85 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 8de3299..62e966f 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/of_gpio.h>
> >  #include <linux/pinctrl/consumer.h>
> >  #include <linux/platform_device.h>
> 
> Add pm.h as well.
> 
OK, will add it.
> > +#include <linux/pm_runtime.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/spinlock.h>
> >
> 
> [...]
> 
> Kind regards
> Uffe
