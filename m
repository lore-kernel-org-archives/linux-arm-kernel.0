From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 28 Jun 2014 19:07:09 +0200
Subject: [PATCH 2/6] mailbox/omap: add support for parsing dt devices
In-Reply-To: <1403660878-56350-3-git-send-email-s-anna@ti.com>
References: <1403660878-56350-1-git-send-email-s-anna@ti.com>
 <1403660878-56350-3-git-send-email-s-anna@ti.com>
Message-ID: <20140628170709.GB23634@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> The non-DT support has to be maintained for now to not break
> OMAP3 legacy boot, and the legacy-style code will be cleaned
> up once OMAP3 is also converted to DT-boot only.

> @@ -587,24 +606,157 @@ static int omap_mbox_unregister(struct omap_mbox_device *mdev)
>  	return 0;
>  }
>  
> +static const struct omap_mbox_device_data omap2_data = {
> +	.num_users	= 4,
> +	.num_fifos	= 6,
> +	.intr_type	= MBOX_INTR_CFG_TYPE1,
> +};
> +
> +static const struct omap_mbox_device_data omap3_data = {
> +	.num_users	= 2,
> +	.num_fifos	= 2,
> +	.intr_type	= MBOX_INTR_CFG_TYPE1,
> +};
> +
> +static const struct omap_mbox_device_data am335x_data = {
> +	.num_users	= 4,
> +	.num_fifos	= 8,
> +	.intr_type	= MBOX_INTR_CFG_TYPE2,
> +};

So you use compatible strings to look up 3 integers. Would it be better to have
num_users/num_fifos/intr_type directly in the device tree? That should be cleaner
and more flexible...

If you do that, would it be possible to have share compatible string?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
