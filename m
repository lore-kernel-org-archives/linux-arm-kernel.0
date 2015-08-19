From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 19 Aug 2015 16:36:30 -0500
Subject: [PATCHv2 0/2] USB: Enable EHCI-platform driver for use with ACPI
Message-ID: <1440020192-23754-1-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set enables USB on the ARM Juno development platform when
using an ACPI kernel.

First it adds an error message if the device cannot be configured with
the current DMA settings (missing/unsupported CCA attribute). It then
adds the ACPI PNP id to the acpi_match_table entry.

Tested-by: Huang Shijie <shijie.huang@arm.com>
Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Jeremy Linton (2):
  USB: ehci-platform: Display a DMA configuration error message
  USB: ehci-platform: Add ACPI bindings for the EHCI platform driver.

 drivers/usb/host/ehci-platform.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.4.3
