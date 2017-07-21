From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 21 Jul 2017 08:47:20 -0700
Subject: [RFC PATCH 1/4] serial: uartps: Remove console_initcall from the
 driver
In-Reply-To: <bd75a2ab5838ae1cf44af667e24be2f02c2e9f3c.1500629544.git.michal.simek@xilinx.com>
References: <cover.1500629544.git.michal.simek@xilinx.com>
 <bd75a2ab5838ae1cf44af667e24be2f02c2e9f3c.1500629544.git.michal.simek@xilinx.com>
Message-ID: <20170721154720.ifjsn3og6apqi7mv@xsjsorenbubuntu.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-07-21 at 11:32:24 +0200, Michal Simek wrote:
> register_console() is called from
> uart_add_one_port()->uart_configure_port()
> that's why register_console() is called twice.
> 
> This patch remove console_initcall to call register_console() only from
> one location.
> 
> Also based on my tests cdns_uart_console_setup() is not called
> from the first register_console() call.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> I am not quite sure about this because console_initcall is called
> early but I can see any difference in usage.
> pl011 is not calling this but others are doing it.

Doesn't this break early console/printk? I would expect that the UART
initialization may happen later than console init.

	S?ren
