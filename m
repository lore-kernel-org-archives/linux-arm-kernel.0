From: corbet@lwn.net (Jonathan Corbet)
Date: Wed, 28 Jan 2015 14:58:43 -0700
Subject: [PATCH 7/7] [media] marvell-ccic needs VIDEOBUF2_DMA_SG
In-Reply-To: <1422479867-3370921-8-git-send-email-arnd@arndb.de>
References: <1422479867-3370921-1-git-send-email-arnd@arndb.de>
 <1422479867-3370921-8-git-send-email-arnd@arndb.de>
Message-ID: <20150128145843.16683733@lwn.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Jan 2015 22:17:47 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> The vb2_dma_sg_memops pointer is only valid if VIDEOBUF2_DMA_SG is
> set, so we should select that to avoid this build error:
> 
> drivers/built-in.o: In function `mcam_v4l_open':
> :(.text+0x388d00): undefined reference to `vb2_dma_sg_memops'

I acked this one the last time it came around (I forget from who).  I
still don't know how to create a .config that exposes the problem, but
others have clearly succeeded in doing it.

Acked-by: Jonathan Corbet <corbet@lwn.net>

jon
