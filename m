From: mathias.nyman@intel.com (Mathias Nyman)
Date: Fri, 04 Dec 2015 14:06:30 +0200
Subject: [PATCH] usb: xhci: fix config fail of FS hub behind a HS hub
 with MTT
In-Reply-To: <1449123254-21654-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1449123254-21654-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <566181C6.6090107@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.12.2015 08:14, Chunfeng Yun wrote:
> if a full speed hub connects to a high speed hub which
> supports MTT, the MTT field of its slot context will be set
> to 1 when xHCI driver setups an xHCI virtual device in
> xhci_setup_addressable_virt_dev(); once usb core fetch its
> hub descriptor, and need to update the xHC's internal data
> structures for the device, the HUB field of its slot context
> will be set to 1 too, meanwhile MTT is also set before,
> this will cause configure endpoint command fail, so in the
> case, we should clear MTT to 0 for full speed hub according
> to section 6.2.2
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---

Thanks, patch added to queue

-Mathias
