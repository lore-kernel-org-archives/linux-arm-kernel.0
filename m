From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Fri, 23 Dec 2016 16:07:49 +0300
Subject: arm64: mm: bug around swiotlb_dma_ops
In-Reply-To: <549c88f2-4a17-1b92-4478-e58aa0dd104f@cogentembedded.com>
References: <8862fe21-0a82-a09a-c1cb-aa79d46179ec@cogentembedded.com>
 <2687486.uRNLKRAd5t@wuerfel>
 <549c88f2-4a17-1b92-4478-e58aa0dd104f@cogentembedded.com>
Message-ID: <63639fa4-240b-0f7b-1adb-b79b2f33bef8@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If trying to avoid big changes and only fixing particular problem with
> particular device not working on arm64, I think best way is to
> alter__swiotlb_dma_supported() in arch/arm64/mm/dma-mapping.c to detect
> and decline (with -EIO) mask that is unsupported by device connection.
> This will cover both dma_mask and coherent_dma_mask.
> 
> This has to be combined with some way to explicitly extract information
> about limitations. Checking device parent's dma masks won't work unless
> somebody bothers to populate them.

I'm trying to bring together a patch doing this, will post that when ready
