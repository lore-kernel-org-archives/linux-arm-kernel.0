From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 16 Jul 2018 09:13:37 +1000
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20180716091337.6c1b2a4d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the arm-soc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

sound/arm/pxa2xx-pcm-lib.c: In function '__pxa2xx_pcm_open':
sound/arm/pxa2xx-pcm-lib.c:129:6: error: 'pxad_filter_fn' undeclared (first use in this function); did you mean 'dma_filter_fn'?
      pxad_filter_fn,
      ^~~~~~~~~~~~~~
      dma_filter_fn

Caused by commit

  0d0b16b8e008 ("dmaengine: pxa: make the filter function internal")

I have used the arm-soc tree from next-20180713 for today.

-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180716/b55d2790/attachment.sig>
