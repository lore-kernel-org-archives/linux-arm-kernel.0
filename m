From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Mon, 15 May 2017 14:28:24 +0800
Subject: [PATCH 0/2] gpio: add imx7ulp gpio support
Message-ID: <1494829706-5661-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Rapid General-Purpose Input and Output with 2 Ports (RGPIO2P)
on MX7ULP is similar to GPIO on Vibrid. But unlike Vibrid, the
RGPIO2P has an extra Port Data Direction Register (PDDR) used
to configure the individual port pins for input or output.

We introduce a FSL_GPIO_HAVE_PDDR with fsl_gpio_soc_data data
to distinguish this differences. And we support getting the output
status by checking the GPIO direction in PDDR.

Dong Aisheng (2):
  dt-bindings: gpio-vf610: add imx7ulp support
  gpio: gpio-vf610: add imx7ulp support

 .../devicetree/bindings/gpio/gpio-vf610.txt        |  4 +-
 drivers/gpio/gpio-vf610.c                          | 49 ++++++++++++++++++++--
 2 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.7.4
