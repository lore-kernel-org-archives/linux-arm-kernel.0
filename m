From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 13 Jan 2015 15:36:54 +0100
Subject: [PATCH] i2c: designware: use {readl|writel}_relaxed instead of
 readl/writel
In-Reply-To: <1418279201-3886-1-git-send-email-jszhang@marvell.com>
References: <1418279201-3886-1-git-send-email-jszhang@marvell.com>
Message-ID: <20150113143654.GG7660@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, Dec 11, 2014 at 02:26:41PM +0800, Jisheng Zhang wrote:
> readl/writel is too expensive especially on Cortex A9 w/ outer L2 cache.
> This introduces i2c read/write errors on Marvell BG2/BG2Q SoCs when there
> are heavy L2 cache maintenance operations at the same time.

Reading this again, I got a question:

Really read/write errors? I would think that there is a performance
penalty because of the memory barriers. But errors?

> The driver does not perform DMA, so it's safe to use the relaxed version.
> From another side, the relaxed io accessor macros are available on all
> architectures now, so we can use the relaxed versions instead.

Can the designware core make use of DMA in theory?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/471af9f5/attachment.sig>
