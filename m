From: alexanders83@web.de (Alexander Stein)
Date: Fri, 19 Dec 2014 09:51:37 +0100
Subject: [PATCH 0/3] add Atmel EBI (External Bus Interface) DT nodes for
 AT91SAM9263
Message-ID: <1418979100-13243-1-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is based on and requires Boris' work on an EBI driver for AT91. Please
refer to https://lkml.org/lkml/2014/12/3/806.
The reason I added no pinctrl is that those pins from EBI1 in my case are not
muxable. They are fixed so there is nothing I can test here.
I used this patchset and the EBI to configure a PSRAM to be used by the
atmel_lcdfb driver which works so far.
This also means EBI0 is rather untested, but it should behave like EBI1 if
the numbers are correct.

Best regards,
Alexander

Alexander Stein (3):
  ARM: at91/dt: add matrix node in at91sam9263 dtsi
  ARM: at91/dt: add SMC0/1  nodes in at91sam9263 dtsi
  ARM: at91/dt: add EBI (External Bus Interface) node in at91sam9263
    dtsi

 arch/arm/boot/dts/at91sam9263.dtsi | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

-- 
2.2.1
