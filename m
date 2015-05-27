From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 May 2015 07:18:43 -0500
Subject: [PATCH 3/6] xhci: probe phy before add usb_hcd
In-Reply-To: <1432727283-20303-4-git-send-email-chunfeng.yun@mediatek.com>
References: <1432727283-20303-1-git-send-email-chunfeng.yun@mediatek.com>
 <1432727283-20303-4-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <20150527121843.GA8611@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 07:48:00PM +0800, chunfeng.yun at mediatek.com wrote:
> From: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> find the phy driver before add primary usb_hcd to avoid acessing
> xHCI register which may hangup the system when the phy is not loaded
> yet and the related powers or clocks put in phy driver are not
> enabled.

it seems like the same clock is needed by PHY and XHCI. This patch looks
incorrect.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150527/5a79bb54/attachment.sig>
