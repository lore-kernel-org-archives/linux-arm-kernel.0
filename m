From: lkp@intel.com (kbuild test robot)
Date: Mon, 21 May 2018 22:42:31 +0800
Subject: [PATCH 2/2] rtc: st-lpc: add range
In-Reply-To: <20180520123337.14856-2-alexandre.belloni@bootlin.com>
References: <20180520123337.14856-2-alexandre.belloni@bootlin.com>
Message-ID: <201805212019.zrThM1dn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

I love your patch! Yet something to improve:

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on v4.17-rc6 next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexandre-Belloni/rtc-st-lpc-fix-possible-race-condition/20180521-192317
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/rtc/rtc-st-lpc.c: In function 'st_rtc_probe':
>> drivers/rtc/rtc-st-lpc.c:261:5: error: 'struct st_rtc' has no member named 'range_max'
     rtc->range_max = do_div(U64_MAX, rtc->clkrate);
        ^~
   In file included from arch/arm/include/asm/div64.h:127:0,
                    from include/linux/kernel.h:173,
                    from include/linux/clk.h:16,
                    from drivers/rtc/rtc-st-lpc.c:17:
>> include/asm-generic/div64.h:226:7: error: lvalue required as left operand of assignment
      (n) >>= ilog2(__base);   \
          ^
>> drivers/rtc/rtc-st-lpc.c:261:19: note: in expansion of macro 'do_div'
     rtc->range_max = do_div(U64_MAX, rtc->clkrate);
                      ^~~~~~
>> include/asm-generic/div64.h:230:31: warning: large integer implicitly truncated to unsigned type [-Woverflow]
      uint32_t __res_lo, __n_lo = (n); \
                                  ^
>> drivers/rtc/rtc-st-lpc.c:261:19: note: in expansion of macro 'do_div'
     rtc->range_max = do_div(U64_MAX, rtc->clkrate);
                      ^~~~~~
   include/asm-generic/div64.h:231:7: error: lvalue required as left operand of assignment
      (n) = __div64_const32(n, __base); \
          ^
>> drivers/rtc/rtc-st-lpc.c:261:19: note: in expansion of macro 'do_div'
     rtc->range_max = do_div(U64_MAX, rtc->clkrate);
                      ^~~~~~
   include/asm-generic/div64.h:233:14: warning: large integer implicitly truncated to unsigned type [-Woverflow]
      __res_lo = (n);    \
                 ^
>> drivers/rtc/rtc-st-lpc.c:261:19: note: in expansion of macro 'do_div'
     rtc->range_max = do_div(U64_MAX, rtc->clkrate);
                      ^~~~~~
   include/asm-generic/div64.h:237:7: error: lvalue required as left operand of assignment
      (n) = (uint32_t)(n) / __base;  \
          ^
>> drivers/rtc/rtc-st-lpc.c:261:19: note: in expansion of macro 'do_div'
     rtc->range_max = do_div(U64_MAX, rtc->clkrate);
                      ^~~~~~
>> include/asm-generic/div64.h:239:22: error: lvalue required as unary '&' operand
      __rem = __div64_32(&(n), __base); \
                         ^
>> drivers/rtc/rtc-st-lpc.c:261:19: note: in expansion of macro 'do_div'
     rtc->range_max = do_div(U64_MAX, rtc->clkrate);
                      ^~~~~~
--
   drivers//rtc/rtc-st-lpc.c: In function 'st_rtc_probe':
   drivers//rtc/rtc-st-lpc.c:261:5: error: 'struct st_rtc' has no member named 'range_max'
     rtc->range_max = do_div(U64_MAX, rtc->clkrate);
        ^~
   In file included from arch/arm/include/asm/div64.h:127:0,
                    from include/linux/kernel.h:173,
                    from include/linux/clk.h:16,
                    from drivers//rtc/rtc-st-lpc.c:17:
>> include/asm-generic/div64.h:226:7: error: lvalue required as left operand of assignment
      (n) >>= ilog2(__base);   \
          ^
   drivers//rtc/rtc-st-lpc.c:261:19: note: in expansion of macro 'do_div'
     rtc->range_max = do_div(U64_MAX, rtc->clkrate);
                      ^~~~~~
>> include/asm-generic/div64.h:230:31: warning: large integer implicitly truncated to unsigned type [-Woverflow]
      uint32_t __res_lo, __n_lo = (n); \
                                  ^
   drivers//rtc/rtc-st-lpc.c:261:19: note: in expansion of macro 'do_div'
     rtc->range_max = do_div(U64_MAX, rtc->clkrate);
                      ^~~~~~
   include/asm-generic/div64.h:231:7: error: lvalue required as left operand of assignment
      (n) = __div64_const32(n, __base); \
          ^
   drivers//rtc/rtc-st-lpc.c:261:19: note: in expansion of macro 'do_div'
     rtc->range_max = do_div(U64_MAX, rtc->clkrate);
                      ^~~~~~
   include/asm-generic/div64.h:233:14: warning: large integer implicitly truncated to unsigned type [-Woverflow]
      __res_lo = (n);    \
                 ^
   drivers//rtc/rtc-st-lpc.c:261:19: note: in expansion of macro 'do_div'
     rtc->range_max = do_div(U64_MAX, rtc->clkrate);
                      ^~~~~~
   include/asm-generic/div64.h:237:7: error: lvalue required as left operand of assignment
      (n) = (uint32_t)(n) / __base;  \
          ^
   drivers//rtc/rtc-st-lpc.c:261:19: note: in expansion of macro 'do_div'
     rtc->range_max = do_div(U64_MAX, rtc->clkrate);
                      ^~~~~~
>> include/asm-generic/div64.h:239:22: error: lvalue required as unary '&' operand
      __rem = __div64_32(&(n), __base); \
                         ^
   drivers//rtc/rtc-st-lpc.c:261:19: note: in expansion of macro 'do_div'
     rtc->range_max = do_div(U64_MAX, rtc->clkrate);
                      ^~~~~~

vim +261 drivers/rtc/rtc-st-lpc.c

   192	
   193	static int st_rtc_probe(struct platform_device *pdev)
   194	{
   195		struct device_node *np = pdev->dev.of_node;
   196		struct st_rtc *rtc;
   197		struct resource *res;
   198		uint32_t mode;
   199		int ret = 0;
   200	
   201		ret = of_property_read_u32(np, "st,lpc-mode", &mode);
   202		if (ret) {
   203			dev_err(&pdev->dev, "An LPC mode must be provided\n");
   204			return -EINVAL;
   205		}
   206	
   207		/* LPC can either run as a Clocksource or in RTC or WDT mode */
   208		if (mode != ST_LPC_MODE_RTC)
   209			return -ENODEV;
   210	
   211		rtc = devm_kzalloc(&pdev->dev, sizeof(struct st_rtc), GFP_KERNEL);
   212		if (!rtc)
   213			return -ENOMEM;
   214	
   215		rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
   216		if (IS_ERR(rtc->rtc_dev))
   217			return PTR_ERR(rtc->rtc_dev);
   218	
   219		spin_lock_init(&rtc->lock);
   220	
   221		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   222		rtc->ioaddr = devm_ioremap_resource(&pdev->dev, res);
   223		if (IS_ERR(rtc->ioaddr))
   224			return PTR_ERR(rtc->ioaddr);
   225	
   226		rtc->irq = irq_of_parse_and_map(np, 0);
   227		if (!rtc->irq) {
   228			dev_err(&pdev->dev, "IRQ missing or invalid\n");
   229			return -EINVAL;
   230		}
   231	
   232		ret = devm_request_irq(&pdev->dev, rtc->irq, st_rtc_handler, 0,
   233				       pdev->name, rtc);
   234		if (ret) {
   235			dev_err(&pdev->dev, "Failed to request irq %i\n", rtc->irq);
   236			return ret;
   237		}
   238	
   239		enable_irq_wake(rtc->irq);
   240		disable_irq(rtc->irq);
   241	
   242		rtc->clk = clk_get(&pdev->dev, NULL);
   243		if (IS_ERR(rtc->clk)) {
   244			dev_err(&pdev->dev, "Unable to request clock\n");
   245			return PTR_ERR(rtc->clk);
   246		}
   247	
   248		clk_prepare_enable(rtc->clk);
   249	
   250		rtc->clkrate = clk_get_rate(rtc->clk);
   251		if (!rtc->clkrate) {
   252			dev_err(&pdev->dev, "Unable to fetch clock rate\n");
   253			return -EINVAL;
   254		}
   255	
   256		device_set_wakeup_capable(&pdev->dev, 1);
   257	
   258		platform_set_drvdata(pdev, rtc);
   259	
   260		rtc->rtc_dev->ops = &st_rtc_ops;
 > 261		rtc->range_max = do_div(U64_MAX, rtc->clkrate);
   262	
   263		ret = rtc_register_device(rtc->rtc_dev);
   264		if (ret) {
   265			clk_disable_unprepare(rtc->clk);
   266			return ret;
   267		}
   268	
   269		return 0;
   270	}
   271	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43343 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/7bf5deb2/attachment-0001.gz>
