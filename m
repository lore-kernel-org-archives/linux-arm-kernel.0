From: marc@cpdesign.com.au (Marc Reilly)
Date: Sun,  1 Apr 2012 16:41:35 +1000
Subject: mc13xxx: add I2C support, V5
Message-ID: <1333262499-25871-1-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series (against mfd-2.6/for-next) changes the mc13xxx driver to use 
regmap and adds I2C support.
It has a compile dependency on regmap/for-next, as the spi driver uses the
recently added pad_bits config field.

Patch 2/4 has:
Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Patch 4/4 has:
Signed-off-by: Oskar Schirmer <oskar@scara.com>

Changes since:
V4:
- Fix compile error when CONFIG_OF enabled
- Select REGMAP_I2C and REGMAP_SPI for appropriate drivers.

V3:
- spi driver uses padded register format (reads should actually work now!)
- mc13873 removed from I2C driver
- fix memory leak on probe error

Cheers,
Marc
