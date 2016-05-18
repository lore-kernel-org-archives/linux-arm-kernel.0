From: slash.tmp@free.fr (Mason)
Date: Wed, 18 May 2016 17:24:51 +0200
Subject: [PATCH v2 omap 3/6] arm: Add _rcuidle tracepoints to allow
 clk_core_disable() use from idle
In-Reply-To: <1463424608-20237-3-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20160516184844.GA20144@linux.vnet.ibm.com>
 <1463424608-20237-3-git-send-email-paulmck@linux.vnet.ibm.com>
Message-ID: <573C8943.6090104@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/2016 20:50, Paul E. McKenney wrote:

>> stack backtrace:
>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc5-next-20160426+ #1114
>> Hardware name: Generic OMAP36xx (Flattened Device Tree)
>> [<c0110290>] (unwind_backtrace) from [<c010c3a8>] (show_stack+0x10/0x14)
>> [<c010c3a8>] (show_stack) from [<c047fd68>] (dump_stack+0xb0/0xe4)
>> [<c047fd68>] (dump_stack) from [<c0631618>] (clk_core_disable+0x17c/0x348)
>> [<c0631618>] (clk_core_disable) from [<c0632774>] (clk_disable+0x24/0x30)
>> [<c0632774>] (clk_disable) from [<c0120590>] (_disable_clocks+0x18/0x7c)
>> [<c0120590>] (_disable_clocks) from [<c0121680>] (_idle+0x12c/0x230)
>> [<c0121680>] (_idle) from [<c0121b4c>] (omap_hwmod_idle+0x24/0x44)
>> [<c0121b4c>] (omap_hwmod_idle) from [<c0122c24>] (omap_device_idle+0x3c/0x90)
>> [<c0122c24>] (omap_device_idle) from [<c052cc00>] (__rpm_callback+0x2c/0x60)
>> [<c052cc00>] (__rpm_callback) from [<c052cc54>] (rpm_callback+0x20/0x80)
>> [<c052cc54>] (rpm_callback) from [<c052d150>] (rpm_suspend+0x100/0x768)
>> [<c052d150>] (rpm_suspend) from [<c052ec58>] (__pm_runtime_suspend+0x64/0x84)
>> [<c052ec58>] (__pm_runtime_suspend) from [<c04bf25c>] (omap2_gpio_prepare_for_idle+0x5
>> c/0x70)
>> [<c04bf25c>] (omap2_gpio_prepare_for_idle) from [<c0125568>] (omap_sram_idle+0x140/0x2
>> 44)

Wouldn't the stack trace look better without the word wrap?  :-)

Regards.
