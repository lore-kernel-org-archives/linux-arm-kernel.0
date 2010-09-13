From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 13 Sep 2010 15:22:16 +0200
Subject: [PATCH 5/5] spi: amba_pl022: Remove unused fields from
	pl022_config_chip
In-Reply-To: <1284135579-13578-6-git-send-email-wellsk40@gmail.com>
References: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
	<1284135579-13578-6-git-send-email-wellsk40@gmail.com>
Message-ID: <AANLkTimNnA=tNCE7pLiibwB66R86dNmCDpCuQMkTvw9J@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/10  <wellsk40@gmail.com>:

> From: Kevin Wells <wellsk40@gmail.com>
>
> Some of the fields in the pl022_config_chip structure are no
> longer needed with the spi->mode updates. These fields have been
> removed.

I think you have to do a more thorough patch:

drivers/spi/amba-pl022.c: In function 'verify_controller_parameters':
drivers/spi/amba-pl022.c:1598: error: 'struct pl022_config_chip' has
no member named 'lbm'
drivers/spi/amba-pl022.c:1599: error: 'struct pl022_config_chip' has
no member named 'lbm'
drivers/spi/amba-pl022.c:1629: error: 'struct pl022_config_chip' has
no member named 'endian_rx'
(... etc)

Yours,
Linus Walleij
