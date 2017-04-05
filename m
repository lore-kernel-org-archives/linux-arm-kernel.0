From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 5 Apr 2017 17:31:10 +0800
Subject: [nomadik:spear-dma-cleanup 5/6] drivers/dma/amba-pl08x.c:2327:28:
 error: 'pl080_dummy_get_signal' undeclared
Message-ID: <201704051708.KfGV7tnl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git spear-dma-cleanup
head:   8755e46caafbbdd4f55f6f2ac3d9a2f97c468b5d
commit: 03207884e9edad4224f32db65f39794913cfd3a3 [5/6] ARM/dma: pl08x: Move mux handling into driver
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 03207884e9edad4224f32db65f39794913cfd3a3
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/dma/amba-pl08x.c: In function 'pl08x_setup_syscon_signals':
>> drivers/dma/amba-pl08x.c:2327:28: error: 'pl080_dummy_get_signal' undeclared (first use in this function)
      pl08x->get_xfer_signal = pl080_dummy_get_signal;
                               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/amba-pl08x.c:2327:28: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/dma/amba-pl08x.c:2328:28: error: 'pl080_dummy_put_signal' undeclared (first use in this function)
      pl08x->put_xfer_signal = pl080_dummy_put_signal;
                               ^~~~~~~~~~~~~~~~~~~~~~
   At top level:
   drivers/dma/amba-pl08x.c:2306:13: warning: 'pl08x_dummy_put_signal' defined but not used [-Wunused-function]
    static void pl08x_dummy_put_signal(const struct pl08x_channel_data *cd, int ch)
                ^~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/amba-pl08x.c:2301:12: warning: 'pl08x_dummy_get_signal' defined but not used [-Wunused-function]
    static int pl08x_dummy_get_signal(const struct pl08x_channel_data *cd)
               ^~~~~~~~~~~~~~~~~~~~~~

vim +/pl080_dummy_get_signal +2327 drivers/dma/amba-pl08x.c

  2321			}
  2322			pl08x->get_xfer_signal = pl080_spear_get_signal;
  2323			pl08x->put_xfer_signal = pl080_spear_put_signal;
  2324		}
  2325		if (of_device_is_compatible(np, "nxp,lpc32xx-pl080") ||
  2326		    of_device_is_compatible(np, "samsung,s3c-pl080")) {
> 2327			pl08x->get_xfer_signal = pl080_dummy_get_signal;
> 2328			pl08x->put_xfer_signal = pl080_dummy_put_signal;
  2329		}
  2330	
  2331		return 0;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61353 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170405/1adde678/attachment-0001.gz>
