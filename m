From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 19 Nov 2009 10:29:23 -0600
Subject: [PATCH 7/8] pxa: add frame buffer on pxa168 aspenite platform
In-Reply-To: <7c34ac520911190103q4ba79c60w11dfc8255b69abfa@mail.gmail.com>
References: <7c34ac520911160134k57023db1we74073a87a3dd454@mail.gmail.com>
	<f17812d70911162229s43ca6826k29c4c4a7e279144f@mail.gmail.com>
	<7c34ac520911190103q4ba79c60w11dfc8255b69abfa@mail.gmail.com>
Message-ID: <f17812d70911190829u6831a176j7caae7e0bee3fa53@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> + ? ? ? int err = 0;
> + ? ? ? if (on) {
> + ? ? ? ? ? ? ? if (spi_gpio_reset != -1) {
> + ? ? ? ? ? ? ? ? ? ? ? err = gpio_request(spi_gpio_reset, "TPO_LCD_SPI_RESET");
> + ? ? ? ? ? ? ? ? ? ? ? if (err) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? printk(KERN_ERR "failed to request GPIO for TPO LCD RESET\n");
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return err;
> + ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? ? ? ? ? gpio_direction_output(spi_gpio_reset, 0);
> + ? ? ? ? ? ? ? ? ? ? ? msleep(100);

This is really a loooong delay, there any specific reason for such a long
delay, I'm seeing this to slow down the boot up significantly?

Otherwise looks OK to me, and I prefer the defconfig file change to
be a separate patch please.
