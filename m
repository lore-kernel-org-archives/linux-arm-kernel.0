From: federico.vaga@gmail.com (Federico Vaga)
Date: Thu, 10 Jan 2013 15:32:37 +0100
Subject: [PATCH v5 1/3] videobuf2-dma-contig: user can specify GFP flags
In-Reply-To: <1357822010-30419-2-git-send-email-federico.vaga@gmail.com>
References: <1357822010-30419-1-git-send-email-federico.vaga@gmail.com>
 <1357822010-30419-2-git-send-email-federico.vaga@gmail.com>
Message-ID: <2134637.remWHy6RQA@harkonnen>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>  struct vb2_dc_buf {
> @@ -165,7 +166,8 @@ static void *vb2_dc_alloc(void *alloc_ctx, unsigned long
> size) /* align image size to PAGE_SIZE */
>  	size = PAGE_ALIGN(size);
> 
> -	buf->vaddr = dma_alloc_coherent(dev, size, &buf->dma_addr, 
GFP_KERNEL);
> +	buf->vaddr = dma_alloc_coherent(dev, size, &buf->dma_addr,
> +									
GFP_KERNEL | conf->mem_flags);

Unfortunately, I forgot to remove this from Patch v4 series. I did not see it 
while re-reading the first time. I'll send a new patch series (v6). It should 
be:

buf->vaddr = dma_alloc_coherent(dev, size, &buf->dma_addr, conf->mem_flags);


I'm terribly sorry

-- 
Federico Vaga
