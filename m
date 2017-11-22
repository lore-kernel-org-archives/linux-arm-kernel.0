From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Nov 2017 18:25:02 -0500
Subject: [PATCH V2 09/29] drm/i915: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511390964-9979-10-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
 <1511390964-9979-10-git-send-email-okaya@codeaurora.org>
Message-ID: <4c12bca7-3827-c85a-56d5-d5d10890d40d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2017 5:49 PM, Sinan Kaya wrote:
>  static int i915_get_bridge_dev(struct drm_i915_private *dev_priv)
>  {
> -	dev_priv->bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
> +	u32 domain = pci_domain_nr(dev_priv->drm.pdev->bus);

I'll convert domain type to int on the next version across the series.

I tried to convert most of the drivers to use pci_domain_nr() per feedback
from Greg KH. I'll hold onto posting a new version until I gather feedback
with the approach I have taken.

I just did a build test with the series.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
