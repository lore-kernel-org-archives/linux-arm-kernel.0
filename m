From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 21 Aug 2014 13:46:24 -0500
Subject: [PATCH v3 2/3] ata: Add Qualcomm ARM SoC AHCI SATA host
 controller driver
In-Reply-To: <1403030217-21554-1-git-send-email-galak@codeaurora.org>
References: <1403030217-21554-1-git-send-email-galak@codeaurora.org>
Message-ID: <6726054A-9CF9-4A5C-A98E-4D44A5782076@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jun 17, 2014, at 1:36 PM, Kumar Gala <galak@codeaurora.org> wrote:

> Add support for the Qualcomm AHCI SATA controller that exists on several
> SoC and specifically the IPQ806x family of chips.  The IPQ806x SATA support
> requires the associated IPQ806x SATA PHY Driver to be enabled as well.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
> v3:
> * Added comment about suspend/resume not supported
> * Fixup ahci_platform_init_host for upstream change to interface
> * cleanup error handling of rxoob clk, moved to devm_clk_get/put
> 
> v2:
> * Fixed MODULE_LICENSE to be GPL v2
> 
> drivers/ata/Kconfig     | 10 ++++++
> drivers/ata/Makefile    |  1 +
> drivers/ata/ahci_qcom.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 101 insertions(+)
> create mode 100644 drivers/ata/ahci_qcom.c

Any other comments on these patches?

I?ll send an update that builds against top of tree.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
