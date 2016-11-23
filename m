From: lkp@intel.com (kbuild test robot)
Date: Thu, 24 Nov 2016 04:07:48 +0800
Subject: [PATCH 1/4] serial: core: Add LED trigger support
In-Reply-To: <20161123100106.15969-2-s.hauer@pengutronix.de>
Message-ID: <201611240407.mIazfoB3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on v4.9-rc6 next-20161123]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sascha-Hauer/serial-core-Add-LED-trigger-support/20161124-010846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   make[3]: warning: jobserver unavailable: using -j1.  Add '+' to parent make rule.
   include/linux/init.h:1: warning: no structured comments found
   include/linux/workqueue.h:392: warning: No description found for parameter '...'
   include/linux/workqueue.h:392: warning: Excess function parameter 'args' description in 'alloc_workqueue'
   include/linux/workqueue.h:413: warning: No description found for parameter '...'
   include/linux/workqueue.h:413: warning: Excess function parameter 'args' description in 'alloc_ordered_workqueue'
   include/linux/kthread.h:26: warning: No description found for parameter '...'
   kernel/sys.c:1: warning: no structured comments found
   drivers/dma-buf/seqno-fence.c:1: warning: no structured comments found
   include/linux/fence-array.h:61: warning: No description found for parameter 'fence'
>> drivers/tty/serial/serial_core.c:2773: warning: Excess function parameter 'drv' description in 'uart_remove_led_triggers'
   include/sound/core.h:324: warning: No description found for parameter '...'
   include/sound/core.h:335: warning: No description found for parameter '...'
   include/sound/core.h:388: warning: No description found for parameter '...'
   include/media/media-entity.h:1054: warning: No description found for parameter '...'
   include/net/mac80211.h:2148: WARNING: Inline literal start-string without end-string.
   include/net/mac80211.h:2153: WARNING: Inline literal start-string without end-string.
   include/net/mac80211.h:3202: ERROR: Unexpected indentation.
   include/net/mac80211.h:3205: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/net/mac80211.h:3207: ERROR: Unexpected indentation.
   include/net/mac80211.h:3208: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/net/mac80211.h:1435: WARNING: Inline emphasis start-string without end-string.
   include/net/mac80211.h:1172: WARNING: Inline literal start-string without end-string.
   include/net/mac80211.h:1173: WARNING: Inline literal start-string without end-string.
   include/net/mac80211.h:814: ERROR: Unexpected indentation.
   include/net/mac80211.h:815: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/net/mac80211.h:820: ERROR: Unexpected indentation.
   include/net/mac80211.h:821: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/net/mac80211.h:2489: ERROR: Unexpected indentation.
   include/net/mac80211.h:1768: ERROR: Unexpected indentation.
   include/net/mac80211.h:1772: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/net/mac80211.h:1746: WARNING: Inline emphasis start-string without end-string.
   kernel/sched/fair.c:7259: WARNING: Inline emphasis start-string without end-string.
   kernel/time/timer.c:1240: ERROR: Unexpected indentation.
   kernel/time/timer.c:1242: ERROR: Unexpected indentation.
   kernel/time/timer.c:1243: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:121: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:124: ERROR: Unexpected indentation.
   include/linux/wait.h:126: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:1021: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:317: WARNING: Inline literal start-string without end-string.
   drivers/base/firmware_class.c:1348: WARNING: Bullet list ends without a blank line; unexpected unindent.
   drivers/message/fusion/mptbase.c:5054: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1897: WARNING: Definition list ends without a blank line; unexpected unindent.
   include/linux/spi/spi.h:369: ERROR: Unexpected indentation.
   WARNING: dvipng command 'dvipng' cannot be run (needed for math display), check the imgmath_dvipng setting

vim +2773 drivers/tty/serial/serial_core.c

  2757	err_alloc:
  2758		kfree(uport->led_trigger_tx_name);
  2759		kfree(uport->led_trigger_rx_name);
  2760	
  2761		return ret;
  2762	}
  2763	
  2764	/**
  2765	 *	uart_remove_led_triggers - remove LED triggers
  2766	 *	@drv: pointer to the uart low level driver structure for this port
  2767	 *	@uport: uart port structure to use for this port.
  2768	 *
  2769	 *	Remove LED triggers previously registered with uart_add_led_triggers
  2770	 */
  2771	void uart_remove_led_triggers(struct uart_port *uport)
  2772	{
> 2773		if (uport->led_trigger_rx)
  2774			led_trigger_unregister_simple(uport->led_trigger_rx);
  2775		kfree(uport->led_trigger_rx_name);
  2776	
  2777		if (uport->led_trigger_tx)
  2778			led_trigger_unregister_simple(uport->led_trigger_tx);
  2779		kfree(uport->led_trigger_tx_name);
  2780	}
  2781	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6425 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161124/298326e0/attachment.gz>
