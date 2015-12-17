From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 17 Dec 2015 17:40:14 +1100
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20151217174014.711d87f1@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the arm-soc tree, today's linux-next build (arm defconfig)
failed like this:

*** Default configuration is based on 'versatile_defconfig'
#
# configuration written to .config
#
make[1]: Leaving directory '/home/sfr/next/arm_defconfig'
.config:2033:warning: symbol value '' invalid for DEBUG_UART_PHYS
.config:2034:warning: symbol value '' invalid for DEBUG_UART_VIRT
*
* Restart config...
*
	.
	.
	.
Kernel low-level debugging functions (read help!) (DEBUG_LL) [Y/n/?] y
  Kernel low-level debugging port
    1. Kernel low-level debugging messages via ARM Versatile UART (DEBUG_VERSATILE)
    2. Kernel low-level debugging via EmbeddedICE DCC channel (DEBUG_ICEDCC)
    3. Kernel low-level debug output via semihosting I/O (DEBUG_SEMIHOSTING)
    4. Kernel low-level debugging via 8250 UART (DEBUG_LL_UART_8250)
  > 5. Kernel low-level debugging via ARM Ltd PL01x Primecell UART (DEBUG_LL_UART_PL01X)
  choice[1-5]: 5
Physical base address of debug UART (DEBUG_UART_PHYS) [] (NEW) aborted!

Console input/output is redirected. Run 'make oldconfig' to update configuration.

Presumably caused by the changes to arch/arm/Kconfig.debug in today's
arm-soc tree.

I left it broken for today.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
