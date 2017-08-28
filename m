From: balbi@kernel.org (Felipe Balbi)
Date: Mon, 28 Aug 2017 16:05:29 +0300
Subject: [PATCH] usb: dwc3: Initialize DMA ops/mask for xhci-hcd
In-Reply-To: <1503684135-24207-1-git-send-email-awallis@codeaurora.org>
References: <1503684135-24207-1-git-send-email-awallis@codeaurora.org>
Message-ID: <877exnyh9i.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Adam Wallis <awallis@codeaurora.org> writes:
> The dma ops from the parent DWC device are not getting passed to the
> child xhci-hcd device. This patch makes use of
> platform_device_register_full to set the DMA ops. For the DT/OF case,
> dma_ops were still null after the the device register, so
> of_dma_configure is called in only the OF case.
>
> Signed-off-by: Adam Wallis <awallis@codeaurora.org>

you need to sysdev property, IMO.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170828/1e8e9aff/attachment.sig>
