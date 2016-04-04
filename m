From: balbi@kernel.org (Felipe Balbi)
Date: Mon, 04 Apr 2016 14:45:38 +0300
Subject: [PATCH] usb: dwc3: keystone: drop dma_mask configuration
In-Reply-To: <1459769611-16862-1-git-send-email-grygorii.strashko@ti.com>
References: <1459769611-16862-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <87pou561i5.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Grygorii Strashko <grygorii.strashko@ti.com> writes:
> The Keystone 2 supports DT-boot only, as result dma_mask will be
> always configured properly from DT -
> of_platform_device_create_pdata()->of_dma_configure(). More over,
> dwc3-keystone.c can be built as module and in this case it's unsafe to
> assign local variable as dma_mask.
>
> Hence, remove dma_mask configuration code.
>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

with these two patches from you, does USB Peripheral work on k2 devices ?

I'll drop my k2 changes from my series which I sent on saturday.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160404/e2b5dff0/attachment.sig>
