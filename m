From: balbi@kernel.org (Felipe Balbi)
Date: Tue, 26 Apr 2016 09:17:22 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <1461612094-30939-1-git-send-email-grygorii.strashko@ti.com>
References: <1461612094-30939-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <87d1pcrj0t.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Grygorii Strashko <grygorii.strashko@ti.com> writes:
> Now not all DMA paremters configured properly for "xhci-hcd" platform
> device which is created manually. For example: dma_pfn_offset, dam_ops
> and iommu configuration will not corresponds "dwc3" devices
> configuration. As result, this will cause problems like wrong DMA
> addresses translation on platforms with LPAE enabled like Keystone 2.
>
> When platform is using DT boot mode the DMA configuration will be
> parsed and applied from DT, so, to fix this issue, reuse
> of_dma_configure() API and retrieve DMA configuartion for "xhci-hcd"
> from DWC3 device node.

patch is incomplete. You left out non-DT users which might suffer from
the same problem.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160426/4123100d/attachment.sig>
