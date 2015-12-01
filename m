From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 1 Dec 2015 01:56:55 +0100
Subject: [PATCH v2 1/2] i2c: mediatek: add i2c first write then read
 optimization
In-Reply-To: <1447047839-5223-2-git-send-email-liguo.zhang@mediatek.com>
References: <1447047839-5223-1-git-send-email-liguo.zhang@mediatek.com>
 <1447047839-5223-2-git-send-email-liguo.zhang@mediatek.com>
Message-ID: <20151201005655.GC2064@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 01:43:58PM +0800, Liguo Zhang wrote:
> For platform with auto restart support, between every transfer,
> i2c controller will trigger an interrupt and SW need to handle
> it to start new transfer. When doing write-then-read transfer,
> instead of restart mechanism, using WRRD mode to have controller
> send both transfer in one request to reduce latency.
> 
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> Reviewed-by: Eddie Huang <eddie.huang@mediatek.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/e1db99ff/attachment.sig>
