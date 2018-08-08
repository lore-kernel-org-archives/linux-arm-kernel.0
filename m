From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 8 Aug 2018 22:57:53 +0200
Subject: [PATCH v2 2/3] i2c: Add helper to ease DMA handling
In-Reply-To: <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
 <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
Message-ID: <20180808205752.llowh4bvu2wkuhga@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 07, 2018 at 05:29:54PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> This function is needed by i2c_get_dma_safe_msg_buf() potentially.
> It is used to free DMA safe buffer when DMA operation fails.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

Right, we need something like this. This leaks in the sh_mobile driver,
too :(

I am still thinking if there is a nice way to put this functionality
into i2c_release_dma_safe_msg_buf() itself somehow...

Thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180808/3819ae01/attachment.sig>
