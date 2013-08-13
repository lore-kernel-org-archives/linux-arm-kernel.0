From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 12 Aug 2013 19:56:33 -0500
Subject: [PATCH 4/9] PCI: mvebu: add support for reset on GPIO
In-Reply-To: <1376333215-12885-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376333215-12885-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <BA285A30-3E38-4F7A-BD5E-3271AD1A46BE@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 12, 2013, at 1:46 PM, Sebastian Hesselbarth wrote:

> This patch adds a check for DT passed reset-gpios property and deasserts/
> asserts reset pin on probe/remove with configurable delay. Corresponding
> binding documentation is also updated.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-doc at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-pci at vger.kernel.org
> ---
> .../devicetree/bindings/pci/mvebu-pci.txt          |    2 ++
> drivers/pci/host/pci-mvebu.c                       |   33 +++++++++++++++++++-
> 2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> index 638673a..f2fa261 100644
> --- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> @@ -76,6 +76,8 @@ and the following optional properties:
> - marvell,pcie-lane: the physical PCIe lane number, for ports having
>   multiple lanes. If this property is not found, we assume that the
>   value is 0.
> +- reset-gpios: optional gpio to PERST#
> +- reset-delay-ms: delay in ms to wait after reset de-assertion

Both of these should probably be marvell,reset...

Does reset-delay-ms vary per board?  I can't remember where the discussion got to about configuration info.

> 
> Example:

It's usually good to update example to show all optional properties.

- k
--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
