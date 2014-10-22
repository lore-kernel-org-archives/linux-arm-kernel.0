From: romain.perier@gmail.com (PERIER Romain)
Date: Wed, 22 Oct 2014 17:25:07 +0200
Subject: [PATCH v1 1/5] mfd: tps65910: Convert ti, system-power-controller
 DT property to poweroff-source
In-Reply-To: <1413991587-11110-1-git-send-email-romain.perier@gmail.com>
References: <1413991587-11110-1-git-send-email-romain.perier@gmail.com>
Message-ID: <CABgxDoKus_D=ooCz3TqyXP9CTJUgbZVxQSsw4ZgBx1oYaTefbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is related to the following subject "[RFC v3 PATCH 1/5] of: Add
standard property for poweroff capability" and depends on the
corresponding patch.

2014-10-22 17:26 GMT+02:00 Romain Perier <romain.perier@gmail.com>:
> No longer use custom property to define poweroff capability, use the standard
> DT property instead.
>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  drivers/mfd/tps65910.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
> index 7612d89..b8dca8a 100644
> --- a/drivers/mfd/tps65910.c
> +++ b/drivers/mfd/tps65910.c
> @@ -423,8 +423,7 @@ static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
>
>         board_info->irq = client->irq;
>         board_info->irq_base = -1;
> -       board_info->pm_off = of_property_read_bool(np,
> -                       "ti,system-power-controller");
> +       board_info->pm_off = of_system_has_poweroff_source(np);
>
>         return board_info;
>  }
> --
> 1.9.1
>
