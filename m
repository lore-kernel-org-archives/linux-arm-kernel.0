From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Oct 2015 09:27:03 +0100
Subject: [PATCH v4 4/6] reset: sunxi: Add Allwinner H3 bus resets
In-Reply-To: <1445964626-6484-5-git-send-email-jenskuske@gmail.com>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-5-git-send-email-jenskuske@gmail.com>
Message-ID: <13919923.o3Dj9msmoa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 October 2015 17:50:24 Jens Kuske wrote:
> 
> +static int sun8i_h3_bus_reset_xlate(struct reset_controller_dev *rcdev,
> +                                   const struct of_phandle_args *reset_spec)
> +{
> +       unsigned int index = reset_spec->args[0];
> +
> +       if (index < 96)
> +               return index;
> +       else if (index < 128)
> +               return index + 32;
> +       else if (index < 160)
> +               return index + 64;
> +       else
> +               return -EINVAL;
> +}
> +
> 

This looks like you are doing something wrong and should either
put the actual number into DT, or use a two-cell representation,
with the first cell indicating the block (0, 1 or 2), and the
second cell the index.

	Arnd
