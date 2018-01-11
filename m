From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 11 Jan 2018 08:03:48 +0800
Subject: [nomadik:gemini-ethernet 18/18]
 drivers/net/ethernet/cortina/gemini.c:1410:63: warning: format '%x' expects
 argument of type 'unsigned int', but argument 4 has type 'long unsigned int'
Message-ID: <201801110845.QlMUyv5N%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-ethernet
head:   de0cb586c9e534c926cd7c74c92dc3d4104ea569
commit: de0cb586c9e534c926cd7c74c92dc3d4104ea569 [18/18] net: ethernet: Add a driver for Gemini gigabit ethernet
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        git checkout de0cb586c9e534c926cd7c74c92dc3d4104ea569
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/cortina/gemini.c: In function 'gmac_rx':
>> drivers/net/ethernet/cortina/gemini.c:1410:63: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
       dev_err(geth->dev, "could not find mapping %08x (page = %08x, page off = %08x)\n",
                                                               ~~~^
                                                               %08lx
   In file included from drivers/net/ethernet/cortina/gemini.c:16:0:
   drivers/net/ethernet/cortina/gemini.c: At top level:
   include/linux/module.h:129:42: error: redefinition of '__inittest'
     static inline initcall_t __maybe_unused __inittest(void)  \
                                             ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2567:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:129:42: note: previous definition of '__inittest' was here
     static inline initcall_t __maybe_unused __inittest(void)  \
                                             ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2495:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:131:6: error: redefinition of 'init_module'
     int init_module(void) __attribute__((alias(#initfn)));
         ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2567:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:131:6: note: previous definition of 'init_module' was here
     int init_module(void) __attribute__((alias(#initfn)));
         ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2495:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:135:42: error: redefinition of '__exittest'
     static inline exitcall_t __maybe_unused __exittest(void)  \
                                             ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2567:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:135:42: note: previous definition of '__exittest' was here
     static inline exitcall_t __maybe_unused __exittest(void)  \
                                             ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2495:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:137:7: error: redefinition of 'cleanup_module'
     void cleanup_module(void) __attribute__((alias(#exitfn)));
          ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2567:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:137:7: note: previous definition of 'cleanup_module' was here
     void cleanup_module(void) __attribute__((alias(#exitfn)));
          ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2495:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);

vim +1410 drivers/net/ethernet/cortina/gemini.c

  1359	
  1360	static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
  1361	{
  1362		struct gemini_ethernet_port *port = netdev_priv(netdev);
  1363		unsigned short m = (1 << port->rxq_order) - 1;
  1364		struct gemini_ethernet *geth = port->geth;
  1365		void __iomem *ptr_reg = port->rxq_rwptr;
  1366		unsigned int frame_len, frag_len;
  1367		struct gmac_rxdesc *rx = NULL;
  1368		struct gmac_queue_page *gpage;
  1369		static struct sk_buff *skb;
  1370		union gmac_rxdesc_0 word0;
  1371		union gmac_rxdesc_1 word1;
  1372		union gmac_rxdesc_3 word3;
  1373		struct page *page = NULL;
  1374		unsigned int page_offs;
  1375		unsigned short r, w;
  1376		union dma_rwptr rw;
  1377		dma_addr_t mapping;
  1378		int frag_nr = 0;
  1379	
  1380		rw.bits32 = readl(ptr_reg);
  1381		/* Reset interrupt as all packages until here are taken into account */
  1382		writel(DEFAULT_Q0_INT_BIT << netdev->dev_id,
  1383		       geth->base + GLOBAL_INTERRUPT_STATUS_1_REG);
  1384		r = rw.bits.rptr;
  1385		w = rw.bits.wptr;
  1386	
  1387		while (budget && w != r) {
  1388			rx = port->rxq_ring + r;
  1389			word0 = rx->word0;
  1390			word1 = rx->word1;
  1391			mapping = rx->word2.buf_adr;
  1392			word3 = rx->word3;
  1393	
  1394			r++;
  1395			r &= m;
  1396	
  1397			frag_len = word0.bits.buffer_size;
  1398			frame_len = word1.bits.byte_count;
  1399			page_offs = mapping & ~PAGE_MASK;
  1400	
  1401			if (!mapping) {
  1402				netdev_err(netdev,
  1403					   "rxq[%u]: HW BUG: zero DMA desc\n", r);
  1404				goto err_drop;
  1405			}
  1406	
  1407			/* Freeq pointers are one page off */
  1408			gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
  1409			if (!gpage) {
> 1410				dev_err(geth->dev, "could not find mapping %08x (page = %08x, page off = %08x)\n",
  1411					mapping, mapping & PAGE_MASK, page_offs);
  1412				continue;
  1413			}
  1414			page = gpage->page;
  1415	
  1416			if (word3.bits32 & SOF_BIT) {
  1417				if (skb) {
  1418					napi_free_frags(&port->napi);
  1419					port->stats.rx_dropped++;
  1420				}
  1421	
  1422				skb = gmac_skb_if_good_frame(port, word0, frame_len);
  1423				if (!skb)
  1424					goto err_drop;
  1425	
  1426				page_offs += NET_IP_ALIGN;
  1427				frag_len -= NET_IP_ALIGN;
  1428				frag_nr = 0;
  1429	
  1430			} else if (!skb) {
  1431				put_page(page);
  1432				continue;
  1433			}
  1434	
  1435			if (word3.bits32 & EOF_BIT)
  1436				frag_len = frame_len - skb->len;
  1437	
  1438			/* append page frag to skb */
  1439			if (frag_nr == MAX_SKB_FRAGS)
  1440				goto err_drop;
  1441	
  1442			if (frag_len == 0)
  1443				netdev_err(netdev, "Received fragment with len = 0\n");
  1444	
  1445			skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);
  1446			skb->len += frag_len;
  1447			skb->data_len += frag_len;
  1448			skb->truesize += frag_len;
  1449			frag_nr++;
  1450	
  1451			if (word3.bits32 & EOF_BIT) {
  1452				napi_gro_frags(&port->napi);
  1453				skb = NULL;
  1454				--budget;
  1455			}
  1456			continue;
  1457	
  1458	err_drop:
  1459			if (skb) {
  1460				napi_free_frags(&port->napi);
  1461				skb = NULL;
  1462			}
  1463	
  1464			if (mapping)
  1465				put_page(page);
  1466	
  1467			port->stats.rx_dropped++;
  1468		}
  1469	
  1470		writew(r, ptr_reg);
  1471		return budget;
  1472	}
  1473	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62432 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180111/cd79a02e/attachment-0001.gz>
