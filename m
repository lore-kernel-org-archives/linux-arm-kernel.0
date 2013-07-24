From: stigge@antcom.de (Roland Stigge)
Date: Wed, 24 Jul 2013 12:19:05 +0200
Subject: MAX7301 GPIO: Do not force SPI speed when using OF Platform
Message-ID: <51EFAA19.4020905@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

commit 047b93a35961f7a6561e6f5dcb040738f822b892 introduced the following
to gpio-max7301.c:

	/* bits_per_word cannot be configured in platform data */
-	spi->bits_per_word = 16;
+	if (spi->dev.platform_data)
+		spi->bits_per_word = 16;
 	ret = spi_setup(spi);

Comment is: "The bit_per_word can be set in the OF Device tree, so no
need to force it as with the platform_data when using OF Platform"

Can you please point me to the respective OF option? I couldn't find it
under drivers/spi/spi* or Documentation/devicetree/bindings/spi/*.

Thanks in advance,

Roland
