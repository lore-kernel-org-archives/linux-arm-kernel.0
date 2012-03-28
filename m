From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 28 Mar 2012 12:05:47 +0200
Subject: [PATCH v2 0/3] atmel-mci device tree support 
Message-ID: <1332929150-14240-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch-set adds device tree support for atmel-mci.

Regards

Ludovic

v2:
- squash patch v1 2/4 and 3/4.
- change atmci_get_of_slots to atmci_of_init and manage pdata allocation into
it.
- correct potential issue (e.g. having only one slot which is not slot0 into
the dt) about slots by adding a reg property corresponding to the slot id.


.../devicetree/bindings/mmc/atmel-hsmci.txt        |   67 ++++++++++++++++
arch/arm/boot/dts/at91sam9g25ek.dts                |   16 ++++
arch/arm/boot/dts/at91sam9x5.dtsi                  |   24 ++++++
arch/arm/mach-at91/at91sam9x5.c                    |    2 +
drivers/mmc/host/atmel-mci.c                       |   80 ++++++++++++++++++++
