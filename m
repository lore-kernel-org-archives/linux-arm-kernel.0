From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Thu, 19 Nov 2015 16:53:41 +0100
Subject: [PATCH] spi: dts: sun4i: Add support for inter-word wait cycles
Message-ID: <1447948422-4915-1-git-send-email-mweseloh42@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

the Allwinner A10/A20 SPI module supports an option to configure a number of
clock periods to wait between each word ("SPI Wait Clock Register" in the A20
manual). This is a very useful option if talking to devices which specify a
minimum amount of inter-word wait time.

I initially tried to find a way to let SPI protocol drivers specify this
option, but I couldn't find a mechanism to pass additional options to the spi
master. So I took the spi-davinci driver as an example (it implements a very
similiar functionality) and added a new devicetree property.

While testing this patch I noticed that the SPI module always adds a constant
3 clock cycles to the number set in the Wait Clock Register. That number stays
constant across many different baud rates, so I documented it in the
devicetree binding file.

One thing I am unsure of is the device example in the binding
documentation.  I used "example,dummy" as compatible... is this acceptable or
should I use a device/compatible that actually exists somewhere?

Oh... and should I split binding documentation and code changing patch?

Best regards,

  Marcus


Marcus Weseloh (1):
  spi: dts: sun4i: Add support for inter-word wait cycles using the SPI
    Wait Clock Register

 Documentation/devicetree/bindings/spi/spi-sun4i.txt | 11 +++++++++++
 drivers/spi/spi-sun4i.c                             |  7 +++++++
 2 files changed, 18 insertions(+)

-- 
1.9.1
