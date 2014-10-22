From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 Oct 2014 16:50:58 +0100
Subject: [PATCH v1 1/5] mfd: tps65910: Convert ti, system-power-controller
 DT property to poweroff-source
In-Reply-To: <CABgxDoKus_D=ooCz3TqyXP9CTJUgbZVxQSsw4ZgBx1oYaTefbw@mail.gmail.com>
References: <1413991587-11110-1-git-send-email-romain.perier@gmail.com>
 <CABgxDoKus_D=ooCz3TqyXP9CTJUgbZVxQSsw4ZgBx1oYaTefbw@mail.gmail.com>
Message-ID: <20141022155058.GN4939@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Oct 2014, PERIER Romain wrote:

> This is related to the following subject "[RFC v3 PATCH 1/5] of: Add
> standard property for poweroff capability" and depends on the
> corresponding patch.

Then it should be sent in the same patch-set.

There's nothing I can do with this patch as is.

> 2014-10-22 17:26 GMT+02:00 Romain Perier <romain.perier@gmail.com>:
> > No longer use custom property to define poweroff capability, use the standard
> > DT property instead.
> >
> > Signed-off-by: Romain Perier <romain.perier@gmail.com>
> > ---
> >  drivers/mfd/tps65910.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
> > index 7612d89..b8dca8a 100644
> > --- a/drivers/mfd/tps65910.c
> > +++ b/drivers/mfd/tps65910.c
> > @@ -423,8 +423,7 @@ static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
> >
> >         board_info->irq = client->irq;
> >         board_info->irq_base = -1;
> > -       board_info->pm_off = of_property_read_bool(np,
> > -                       "ti,system-power-controller");
> > +       board_info->pm_off = of_system_has_poweroff_source(np);
> >
> >         return board_info;
> >  }
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
