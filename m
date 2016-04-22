From: lkp@intel.com (kbuild test robot)
Date: Fri, 22 Apr 2016 14:52:13 +0800
Subject: [PATCH v7 6/8] [media] vcodec: mediatek: Add Mediatek VP8 Video
 Encoder Driver
In-Reply-To: <1461299131-57851-7-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <201604221459.IuILoS28%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on v4.6-rc4 next-20160421]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Tiffany-Lin/Add-MT8173-Video-Encoder-Driver-and-VPU-Driver/20160422-123111
base:   git://linuxtv.org/media_tree.git master
config: xtensa-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:13:0,
                    from include/linux/interrupt.h:5,
                    from drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:17:
   drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c: In function 'vp8_enc_alloc_work_buf':
>> drivers/media/platform/mtk-vcodec/venc/../mtk_vcodec_util.h:56:14: warning: format '%lx' expects argument of type 'long unsigned int', but argument 7 has type 'size_t' [-Wformat=]
        ((struct mtk_vcodec_ctx *)h->ctx)->idx, \
                 ^
   include/linux/printk.h:259:34: note: in definition of macro 'pr_info'
     printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                     ^
   drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:214:3: note: in expansion of macro 'mtk_vcodec_debug'
      mtk_vcodec_debug(inst,
      ^
   drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c: In function 'vp8_enc_compose_one_frame':
>> drivers/media/platform/mtk-vcodec/venc/../mtk_vcodec_util.h:62:18: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' [-Wformat=]
            ((struct mtk_vcodec_ctx *)h->ctx)->idx, __func__, ##args)
                     ^
   include/linux/printk.h:252:33: note: in definition of macro 'pr_err'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                    ^
   drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c:279:3: note: in expansion of macro 'mtk_vcodec_err'
      mtk_vcodec_err(inst, "bitstream buf size is too small(%ld)",
      ^

vim +56 drivers/media/platform/mtk-vcodec/venc/../mtk_vcodec_util.h

67e5508b Tiffany Lin 2016-04-22  50  #define mtk_v4l2_debug_leave()  mtk_v4l2_debug(3, "-")
67e5508b Tiffany Lin 2016-04-22  51  
67e5508b Tiffany Lin 2016-04-22  52  #define mtk_vcodec_debug(h, fmt, args...)				\
67e5508b Tiffany Lin 2016-04-22  53  	do {								\
67e5508b Tiffany Lin 2016-04-22  54  		if (mtk_vcodec_dbg)					\
67e5508b Tiffany Lin 2016-04-22  55  			pr_info("[MTK_VCODEC][%d]: %s() " fmt "\n",	\
67e5508b Tiffany Lin 2016-04-22 @56  				((struct mtk_vcodec_ctx *)h->ctx)->idx, \
67e5508b Tiffany Lin 2016-04-22  57  				__func__, ##args);			\
67e5508b Tiffany Lin 2016-04-22  58  	} while (0)
67e5508b Tiffany Lin 2016-04-22  59  
67e5508b Tiffany Lin 2016-04-22  60  #define mtk_vcodec_err(h, fmt, args...)					\
67e5508b Tiffany Lin 2016-04-22  61  	pr_err("[MTK_VCODEC][ERROR][%d]: %s() " fmt "\n",		\
67e5508b Tiffany Lin 2016-04-22 @62  	       ((struct mtk_vcodec_ctx *)h->ctx)->idx, __func__, ##args)
67e5508b Tiffany Lin 2016-04-22  63  
67e5508b Tiffany Lin 2016-04-22  64  #define mtk_vcodec_debug_enter(h)  mtk_vcodec_debug(h, "+")
67e5508b Tiffany Lin 2016-04-22  65  #define mtk_vcodec_debug_leave(h)  mtk_vcodec_debug(h, "-")

:::::: The code at line 56 was first introduced by commit
:::::: 67e5508b437349a82c1a884f6abf3aaa434959e5 vcodec: mediatek: Add Mediatek V4L2 Video Encoder Driver

:::::: TO: Tiffany Lin <tiffany.lin@mediatek.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44849 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160422/b06d72dc/attachment-0001.obj>
