From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 15 Oct 2018 00:33:29 +0200
Subject: [PATCH 1/2] mmc: uniphier-sd: fix DMA disabling
In-Reply-To: <1539356258-12374-2-git-send-email-yamada.masahiro@socionext.com>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
 <1539356258-12374-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20181014223329.GF3260@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 11:57:37PM +0900, Masahiro Yamada wrote:
> Once DMA is enabled, it is not possible to disable it because
> uniphier_sd_dma_endisable() always sets the DMA_ENABLE_DMASDRW bit
> regardless of the argument 'enable'. It should disable DMA when
> 'enable' is false.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181015/2dc3bc28/attachment.sig>
