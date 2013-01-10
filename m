From: federico.vaga@gmail.com (Federico Vaga)
Date: Thu, 10 Jan 2013 13:46:47 +0100
Subject: [PATCH v5] modify videobuf2-dma-contig and update sta2x11_vip
Message-ID: <1357822010-30419-1-git-send-email-federico.vaga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Just one comment about the first patch. I modified the prototype of the 
dma-contig context allocator:

   -void *vb2_dma_contig_init_ctx(struct device *dev);
   +void *vb2_dma_contig_init_ctx(struct device *dev, gfp_t mem_flags);

Now it accepts a gfp_t parameter to specify the memory flags to use during
buffer allocation. I also modified all existent drivers according to this
modification. I cannot do a compile test on every different platform (I don't
have the time and it takes long time); the modification is tiny but just to
be sure please take a look at it.

To find all drivers which use this memory allocator, I simply did:

   git grep -n -C 1 vb2_dma_contig_init_ctx

and edited all the driver found. If I forgot someone, please tell me
