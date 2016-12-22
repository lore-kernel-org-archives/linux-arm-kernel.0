From: lkp@intel.com (kbuild test robot)
Date: Fri, 23 Dec 2016 05:10:45 +0800
Subject: [PATCH v2 11/12] crypto: atmel-authenc: add support to
 authenc(hmac(shaX),Y(aes)) modes
In-Reply-To: <2a6cc4637621d2ef0d84754817128c43795cb022.1482424395.git.cyrille.pitchen@atmel.com>
Message-ID: <201612230500.6HYhIjry%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyrille,

[auto build test WARNING on cryptodev/master]
[also build test WARNING on next-20161222]
[cannot apply to v4.9]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Cyrille-Pitchen/crypto-atmel-authenc-add-support-to-authenc-hmac-shaX-Y-aes-modes/20161223-015820
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:305:0,
                    from include/linux/kernel.h:13,
                    from drivers/crypto/atmel-sha.c:17:
   drivers/crypto/atmel-sha.c: In function 'atmel_sha_xmit_cpu':
>> drivers/crypto/atmel-sha.c:465:19: warning: format '%d' expects argument of type 'int', but argument 6 has type 'size_t {aka long unsigned int}' [-Wformat=]
     dev_dbg(dd->dev, "xmit_cpu: digcnt: 0x%llx 0x%llx, length: %d, final: %d\n",
                      ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/crypto/atmel-sha.c:465:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(dd->dev, "xmit_cpu: digcnt: 0x%llx 0x%llx, length: %d, final: %d\n",
     ^~~~~~~
   drivers/crypto/atmel-sha.c: In function 'atmel_sha_xmit_pdc':
   drivers/crypto/atmel-sha.c:494:19: warning: format '%d' expects argument of type 'int', but argument 6 has type 'size_t {aka long unsigned int}' [-Wformat=]
     dev_dbg(dd->dev, "xmit_pdc: digcnt: 0x%llx 0x%llx, length: %d, final: %d\n",
                      ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
   drivers/crypto/atmel-sha.c:494:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(dd->dev, "xmit_pdc: digcnt: 0x%llx 0x%llx, length: %d, final: %d\n",
     ^~~~~~~
   drivers/crypto/atmel-sha.c: In function 'atmel_sha_xmit_dma':
   drivers/crypto/atmel-sha.c:541:19: warning: format '%d' expects argument of type 'int', but argument 6 has type 'size_t {aka long unsigned int}' [-Wformat=]
     dev_dbg(dd->dev, "xmit_dma: digcnt: 0x%llx 0x%llx, length: %d, final: %d\n",
                      ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
   drivers/crypto/atmel-sha.c:541:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(dd->dev, "xmit_dma: digcnt: 0x%llx 0x%llx, length: %d, final: %d\n",
     ^~~~~~~
   drivers/crypto/atmel-sha.c: In function 'atmel_sha_xmit_dma_map':
>> drivers/crypto/atmel-sha.c:620:26: warning: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'size_t {aka long unsigned int}' [-Wformat=]
      dev_err(dd->dev, "dma %u bytes error\n", ctx->buflen +
                             ^
   In file included from include/linux/printk.h:305:0,
                    from include/linux/kernel.h:13,
                    from drivers/crypto/atmel-sha.c:17:
   drivers/crypto/atmel-sha.c: In function 'atmel_sha_update_dma_slow':
   drivers/crypto/atmel-sha.c:641:19: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'size_t {aka long unsigned int}' [-Wformat=]
     dev_dbg(dd->dev, "slow: bufcnt: %u, digcnt: 0x%llx 0x%llx, final: %d\n",
                      ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
   drivers/crypto/atmel-sha.c:641:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(dd->dev, "slow: bufcnt: %u, digcnt: 0x%llx 0x%llx, final: %d\n",
     ^~~~~~~
   drivers/crypto/atmel-sha.c: In function 'atmel_sha_update_dma_start':
   drivers/crypto/atmel-sha.c:669:19: warning: format '%u' expects argument of type 'unsigned int', but argument 6 has type 'size_t {aka long unsigned int}' [-Wformat=]
     dev_dbg(dd->dev, "fast: digcnt: 0x%llx 0x%llx, bufcnt: %u, total: %u\n",
                      ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
   drivers/crypto/atmel-sha.c:669:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(dd->dev, "fast: digcnt: 0x%llx 0x%llx, bufcnt: %u, total: %u\n",
     ^~~~~~~
   drivers/crypto/atmel-sha.c:711:27: warning: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'size_t {aka long unsigned int}' [-Wformat=]
       dev_err(dd->dev, "dma %u bytes error\n",
                              ^
   In file included from include/linux/printk.h:305:0,
                    from include/linux/kernel.h:13,
                    from drivers/crypto/atmel-sha.c:17:
   drivers/crypto/atmel-sha.c: In function 'atmel_sha_finish':
   drivers/crypto/atmel-sha.c:891:19: warning: format '%d' expects argument of type 'int', but argument 6 has type 'size_t {aka long unsigned int}' [-Wformat=]
     dev_dbg(dd->dev, "digcnt: 0x%llx 0x%llx, bufcnt: %d\n", ctx->digcnt[1],
                      ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
   drivers/crypto/atmel-sha.c:891:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(dd->dev, "digcnt: 0x%llx 0x%llx, bufcnt: %d\n", ctx->digcnt[1],
     ^~~~~~~

vim +465 drivers/crypto/atmel-sha.c

ebc82efa Nicolas Royer   2012-07-01  459  			      size_t length, int final)
ebc82efa Nicolas Royer   2012-07-01  460  {
ebc82efa Nicolas Royer   2012-07-01  461  	struct atmel_sha_reqctx *ctx = ahash_request_ctx(dd->req);
ebc82efa Nicolas Royer   2012-07-01  462  	int count, len32;
ebc82efa Nicolas Royer   2012-07-01  463  	const u32 *buffer = (const u32 *)buf;
ebc82efa Nicolas Royer   2012-07-01  464  
d4905b38 Nicolas Royer   2013-02-20 @465  	dev_dbg(dd->dev, "xmit_cpu: digcnt: 0x%llx 0x%llx, length: %d, final: %d\n",
d4905b38 Nicolas Royer   2013-02-20  466  		ctx->digcnt[1], ctx->digcnt[0], length, final);
ebc82efa Nicolas Royer   2012-07-01  467  
ebc82efa Nicolas Royer   2012-07-01  468  	atmel_sha_write_ctrl(dd, 0);
ebc82efa Nicolas Royer   2012-07-01  469  
ebc82efa Nicolas Royer   2012-07-01  470  	/* should be non-zero before next lines to disable clocks later */
d4905b38 Nicolas Royer   2013-02-20  471  	ctx->digcnt[0] += length;
d4905b38 Nicolas Royer   2013-02-20  472  	if (ctx->digcnt[0] < length)
d4905b38 Nicolas Royer   2013-02-20  473  		ctx->digcnt[1]++;
ebc82efa Nicolas Royer   2012-07-01  474  
ebc82efa Nicolas Royer   2012-07-01  475  	if (final)
ebc82efa Nicolas Royer   2012-07-01  476  		dd->flags |= SHA_FLAGS_FINAL; /* catch last interrupt */
ebc82efa Nicolas Royer   2012-07-01  477  
ebc82efa Nicolas Royer   2012-07-01  478  	len32 = DIV_ROUND_UP(length, sizeof(u32));
ebc82efa Nicolas Royer   2012-07-01  479  
ebc82efa Nicolas Royer   2012-07-01  480  	dd->flags |= SHA_FLAGS_CPU;
ebc82efa Nicolas Royer   2012-07-01  481  
ebc82efa Nicolas Royer   2012-07-01  482  	for (count = 0; count < len32; count++)
ebc82efa Nicolas Royer   2012-07-01  483  		atmel_sha_write(dd, SHA_REG_DIN(count), buffer[count]);
ebc82efa Nicolas Royer   2012-07-01  484  
ebc82efa Nicolas Royer   2012-07-01  485  	return -EINPROGRESS;
ebc82efa Nicolas Royer   2012-07-01  486  }
ebc82efa Nicolas Royer   2012-07-01  487  
ebc82efa Nicolas Royer   2012-07-01  488  static int atmel_sha_xmit_pdc(struct atmel_sha_dev *dd, dma_addr_t dma_addr1,
ebc82efa Nicolas Royer   2012-07-01  489  		size_t length1, dma_addr_t dma_addr2, size_t length2, int final)
ebc82efa Nicolas Royer   2012-07-01  490  {
ebc82efa Nicolas Royer   2012-07-01  491  	struct atmel_sha_reqctx *ctx = ahash_request_ctx(dd->req);
ebc82efa Nicolas Royer   2012-07-01  492  	int len32;
ebc82efa Nicolas Royer   2012-07-01  493  
d4905b38 Nicolas Royer   2013-02-20  494  	dev_dbg(dd->dev, "xmit_pdc: digcnt: 0x%llx 0x%llx, length: %d, final: %d\n",
d4905b38 Nicolas Royer   2013-02-20  495  		ctx->digcnt[1], ctx->digcnt[0], length1, final);
ebc82efa Nicolas Royer   2012-07-01  496  
ebc82efa Nicolas Royer   2012-07-01  497  	len32 = DIV_ROUND_UP(length1, sizeof(u32));
ebc82efa Nicolas Royer   2012-07-01  498  	atmel_sha_write(dd, SHA_PTCR, SHA_PTCR_TXTDIS);
ebc82efa Nicolas Royer   2012-07-01  499  	atmel_sha_write(dd, SHA_TPR, dma_addr1);
ebc82efa Nicolas Royer   2012-07-01  500  	atmel_sha_write(dd, SHA_TCR, len32);
ebc82efa Nicolas Royer   2012-07-01  501  
ebc82efa Nicolas Royer   2012-07-01  502  	len32 = DIV_ROUND_UP(length2, sizeof(u32));
ebc82efa Nicolas Royer   2012-07-01  503  	atmel_sha_write(dd, SHA_TNPR, dma_addr2);
ebc82efa Nicolas Royer   2012-07-01  504  	atmel_sha_write(dd, SHA_TNCR, len32);
ebc82efa Nicolas Royer   2012-07-01  505  
ebc82efa Nicolas Royer   2012-07-01  506  	atmel_sha_write_ctrl(dd, 1);
ebc82efa Nicolas Royer   2012-07-01  507  
ebc82efa Nicolas Royer   2012-07-01  508  	/* should be non-zero before next lines to disable clocks later */
d4905b38 Nicolas Royer   2013-02-20  509  	ctx->digcnt[0] += length1;
d4905b38 Nicolas Royer   2013-02-20  510  	if (ctx->digcnt[0] < length1)
d4905b38 Nicolas Royer   2013-02-20  511  		ctx->digcnt[1]++;
ebc82efa Nicolas Royer   2012-07-01  512  
ebc82efa Nicolas Royer   2012-07-01  513  	if (final)
ebc82efa Nicolas Royer   2012-07-01  514  		dd->flags |= SHA_FLAGS_FINAL; /* catch last interrupt */
ebc82efa Nicolas Royer   2012-07-01  515  
ebc82efa Nicolas Royer   2012-07-01  516  	dd->flags |=  SHA_FLAGS_DMA_ACTIVE;
ebc82efa Nicolas Royer   2012-07-01  517  
ebc82efa Nicolas Royer   2012-07-01  518  	/* Start DMA transfer */
ebc82efa Nicolas Royer   2012-07-01  519  	atmel_sha_write(dd, SHA_PTCR, SHA_PTCR_TXTEN);
ebc82efa Nicolas Royer   2012-07-01  520  
ebc82efa Nicolas Royer   2012-07-01  521  	return -EINPROGRESS;
ebc82efa Nicolas Royer   2012-07-01  522  }
ebc82efa Nicolas Royer   2012-07-01  523  
d4905b38 Nicolas Royer   2013-02-20  524  static void atmel_sha_dma_callback(void *data)
d4905b38 Nicolas Royer   2013-02-20  525  {
d4905b38 Nicolas Royer   2013-02-20  526  	struct atmel_sha_dev *dd = data;
d4905b38 Nicolas Royer   2013-02-20  527  
b48b114c Cyrille Pitchen 2016-12-22  528  	dd->is_async = true;
b48b114c Cyrille Pitchen 2016-12-22  529  
d4905b38 Nicolas Royer   2013-02-20  530  	/* dma_lch_in - completed - wait DATRDY */
d4905b38 Nicolas Royer   2013-02-20  531  	atmel_sha_write(dd, SHA_IER, SHA_INT_DATARDY);
d4905b38 Nicolas Royer   2013-02-20  532  }
d4905b38 Nicolas Royer   2013-02-20  533  
d4905b38 Nicolas Royer   2013-02-20  534  static int atmel_sha_xmit_dma(struct atmel_sha_dev *dd, dma_addr_t dma_addr1,
d4905b38 Nicolas Royer   2013-02-20  535  		size_t length1, dma_addr_t dma_addr2, size_t length2, int final)
d4905b38 Nicolas Royer   2013-02-20  536  {
d4905b38 Nicolas Royer   2013-02-20  537  	struct atmel_sha_reqctx *ctx = ahash_request_ctx(dd->req);
d4905b38 Nicolas Royer   2013-02-20  538  	struct dma_async_tx_descriptor	*in_desc;
d4905b38 Nicolas Royer   2013-02-20  539  	struct scatterlist sg[2];
d4905b38 Nicolas Royer   2013-02-20  540  
d4905b38 Nicolas Royer   2013-02-20 @541  	dev_dbg(dd->dev, "xmit_dma: digcnt: 0x%llx 0x%llx, length: %d, final: %d\n",
d4905b38 Nicolas Royer   2013-02-20  542  		ctx->digcnt[1], ctx->digcnt[0], length1, final);
d4905b38 Nicolas Royer   2013-02-20  543  
d4905b38 Nicolas Royer   2013-02-20  544  	dd->dma_lch_in.dma_conf.src_maxburst = 16;
d4905b38 Nicolas Royer   2013-02-20  545  	dd->dma_lch_in.dma_conf.dst_maxburst = 16;
d4905b38 Nicolas Royer   2013-02-20  546  
d4905b38 Nicolas Royer   2013-02-20  547  	dmaengine_slave_config(dd->dma_lch_in.chan, &dd->dma_lch_in.dma_conf);
d4905b38 Nicolas Royer   2013-02-20  548  
d4905b38 Nicolas Royer   2013-02-20  549  	if (length2) {
d4905b38 Nicolas Royer   2013-02-20  550  		sg_init_table(sg, 2);
d4905b38 Nicolas Royer   2013-02-20  551  		sg_dma_address(&sg[0]) = dma_addr1;
d4905b38 Nicolas Royer   2013-02-20  552  		sg_dma_len(&sg[0]) = length1;
d4905b38 Nicolas Royer   2013-02-20  553  		sg_dma_address(&sg[1]) = dma_addr2;
d4905b38 Nicolas Royer   2013-02-20  554  		sg_dma_len(&sg[1]) = length2;
d4905b38 Nicolas Royer   2013-02-20  555  		in_desc = dmaengine_prep_slave_sg(dd->dma_lch_in.chan, sg, 2,
d4905b38 Nicolas Royer   2013-02-20  556  			DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
d4905b38 Nicolas Royer   2013-02-20  557  	} else {
d4905b38 Nicolas Royer   2013-02-20  558  		sg_init_table(sg, 1);
d4905b38 Nicolas Royer   2013-02-20  559  		sg_dma_address(&sg[0]) = dma_addr1;
d4905b38 Nicolas Royer   2013-02-20  560  		sg_dma_len(&sg[0]) = length1;
d4905b38 Nicolas Royer   2013-02-20  561  		in_desc = dmaengine_prep_slave_sg(dd->dma_lch_in.chan, sg, 1,
d4905b38 Nicolas Royer   2013-02-20  562  			DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
d4905b38 Nicolas Royer   2013-02-20  563  	}
d4905b38 Nicolas Royer   2013-02-20  564  	if (!in_desc)
b48b114c Cyrille Pitchen 2016-12-22  565  		atmel_sha_complete(dd, -EINVAL);
d4905b38 Nicolas Royer   2013-02-20  566  
d4905b38 Nicolas Royer   2013-02-20  567  	in_desc->callback = atmel_sha_dma_callback;
d4905b38 Nicolas Royer   2013-02-20  568  	in_desc->callback_param = dd;
d4905b38 Nicolas Royer   2013-02-20  569  
d4905b38 Nicolas Royer   2013-02-20  570  	atmel_sha_write_ctrl(dd, 1);
d4905b38 Nicolas Royer   2013-02-20  571  
d4905b38 Nicolas Royer   2013-02-20  572  	/* should be non-zero before next lines to disable clocks later */
d4905b38 Nicolas Royer   2013-02-20  573  	ctx->digcnt[0] += length1;
d4905b38 Nicolas Royer   2013-02-20  574  	if (ctx->digcnt[0] < length1)
d4905b38 Nicolas Royer   2013-02-20  575  		ctx->digcnt[1]++;
d4905b38 Nicolas Royer   2013-02-20  576  
d4905b38 Nicolas Royer   2013-02-20  577  	if (final)
d4905b38 Nicolas Royer   2013-02-20  578  		dd->flags |= SHA_FLAGS_FINAL; /* catch last interrupt */
d4905b38 Nicolas Royer   2013-02-20  579  
d4905b38 Nicolas Royer   2013-02-20  580  	dd->flags |=  SHA_FLAGS_DMA_ACTIVE;
d4905b38 Nicolas Royer   2013-02-20  581  
d4905b38 Nicolas Royer   2013-02-20  582  	/* Start DMA transfer */
d4905b38 Nicolas Royer   2013-02-20  583  	dmaengine_submit(in_desc);
d4905b38 Nicolas Royer   2013-02-20  584  	dma_async_issue_pending(dd->dma_lch_in.chan);
d4905b38 Nicolas Royer   2013-02-20  585  
d4905b38 Nicolas Royer   2013-02-20  586  	return -EINPROGRESS;
d4905b38 Nicolas Royer   2013-02-20  587  }
d4905b38 Nicolas Royer   2013-02-20  588  
d4905b38 Nicolas Royer   2013-02-20  589  static int atmel_sha_xmit_start(struct atmel_sha_dev *dd, dma_addr_t dma_addr1,
d4905b38 Nicolas Royer   2013-02-20  590  		size_t length1, dma_addr_t dma_addr2, size_t length2, int final)
d4905b38 Nicolas Royer   2013-02-20  591  {
d4905b38 Nicolas Royer   2013-02-20  592  	if (dd->caps.has_dma)
d4905b38 Nicolas Royer   2013-02-20  593  		return atmel_sha_xmit_dma(dd, dma_addr1, length1,
d4905b38 Nicolas Royer   2013-02-20  594  				dma_addr2, length2, final);
d4905b38 Nicolas Royer   2013-02-20  595  	else
d4905b38 Nicolas Royer   2013-02-20  596  		return atmel_sha_xmit_pdc(dd, dma_addr1, length1,
d4905b38 Nicolas Royer   2013-02-20  597  				dma_addr2, length2, final);
d4905b38 Nicolas Royer   2013-02-20  598  }
d4905b38 Nicolas Royer   2013-02-20  599  
ebc82efa Nicolas Royer   2012-07-01  600  static int atmel_sha_update_cpu(struct atmel_sha_dev *dd)
ebc82efa Nicolas Royer   2012-07-01  601  {
ebc82efa Nicolas Royer   2012-07-01  602  	struct atmel_sha_reqctx *ctx = ahash_request_ctx(dd->req);
ebc82efa Nicolas Royer   2012-07-01  603  	int bufcnt;
ebc82efa Nicolas Royer   2012-07-01  604  
ebc82efa Nicolas Royer   2012-07-01  605  	atmel_sha_append_sg(ctx);
ebc82efa Nicolas Royer   2012-07-01  606  	atmel_sha_fill_padding(ctx, 0);
ebc82efa Nicolas Royer   2012-07-01  607  	bufcnt = ctx->bufcnt;
ebc82efa Nicolas Royer   2012-07-01  608  	ctx->bufcnt = 0;
ebc82efa Nicolas Royer   2012-07-01  609  
ebc82efa Nicolas Royer   2012-07-01  610  	return atmel_sha_xmit_cpu(dd, ctx->buffer, bufcnt, 1);
ebc82efa Nicolas Royer   2012-07-01  611  }
ebc82efa Nicolas Royer   2012-07-01  612  
ebc82efa Nicolas Royer   2012-07-01  613  static int atmel_sha_xmit_dma_map(struct atmel_sha_dev *dd,
ebc82efa Nicolas Royer   2012-07-01  614  					struct atmel_sha_reqctx *ctx,
ebc82efa Nicolas Royer   2012-07-01  615  					size_t length, int final)
ebc82efa Nicolas Royer   2012-07-01  616  {
ebc82efa Nicolas Royer   2012-07-01  617  	ctx->dma_addr = dma_map_single(dd->dev, ctx->buffer,
d4905b38 Nicolas Royer   2013-02-20  618  				ctx->buflen + ctx->block_size, DMA_TO_DEVICE);
ebc82efa Nicolas Royer   2012-07-01  619  	if (dma_mapping_error(dd->dev, ctx->dma_addr)) {
ebc82efa Nicolas Royer   2012-07-01 @620  		dev_err(dd->dev, "dma %u bytes error\n", ctx->buflen +
d4905b38 Nicolas Royer   2013-02-20  621  				ctx->block_size);
b48b114c Cyrille Pitchen 2016-12-22  622  		atmel_sha_complete(dd, -EINVAL);
ebc82efa Nicolas Royer   2012-07-01  623  	}

:::::: The code at line 465 was first introduced by commit
:::::: d4905b38d1f6b60761a6fd16f45ebd1fac8b6e1f crypto: atmel-sha - add support for latest release of the IP (0x410)

:::::: TO: Nicolas Royer <nicolas@eukrea.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47848 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161223/43b808a1/attachment-0001.gz>
