From: andrea.adami@gmail.com (Andrea Adami)
Date: Tue, 17 Oct 2017 10:02:48 +0200
Subject: ARM: pxa/corgi: armv5te kernel 4.12 fails to decompress compiled
 with gcc7
In-Reply-To: <f1631768-b26e-62ae-db1f-65686cd0c4de@gmail.com>
References: <CAAQYJAvR2_wqf2Axe4aVMOu08t7w5tNEjK0s3fw_oemtqCRo7g@mail.gmail.com>
 <87a83zsiid.fsf@belgarion.home>
 <CAAQYJAtEmJMc766kUx+bhFCNQKmwK53nSDNL0nFz-9UXSUO5CQ@mail.gmail.com>
 <20171014215042.kfrhb2kjhm7wb7vb@darkstar.musicnaut.iki.fi>
 <87mv4txuid.fsf@belgarion.home>
 <20171015104640.hazujjkbqyik7fgg@darkstar.musicnaut.iki.fi>
 <f1631768-b26e-62ae-db1f-65686cd0c4de@gmail.com>
Message-ID: <CAAQYJAsmOr2qnykO=rWH1N43q3+d27aHMAyXHTXMYpPQ1=9ikA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<cut>

Hi,

I am trying to debug further but I don't have any output on serial console...
I enabled:

CONFIG_DEBUG_LL=y
CONFIG_DEBUG_PXA_UART1=y
# CONFIG_DEBUG_ICEDCC is not set
# CONFIG_DEBUG_SEMIHOSTING is not set
# CONFIG_DEBUG_LL_UART_8250 is not set
# CONFIG_DEBUG_LL_UART_PL01X is not set
CONFIG_DEBUG_LL_INCLUDE="debug/8250.S"
CONFIG_DEBUG_UART_8250=y
CONFIG_DEBUG_UART_PHYS=0x40100000
CONFIG_DEBUG_UART_VIRT=0xf6200000
CONFIG_DEBUG_UART_8250_SHIFT=2
# CONFIG_DEBUG_UART_8250_WORD is not set
# CONFIG_DEBUG_UART_8250_PALMCHIP is not set
# CONFIG_DEBUG_UART_8250_FLOW_CONTROL is not set
CONFIG_UNCOMPRESS_INCLUDE="mach/uncompress.h"
CONFIG_EARLY_PRINTK=y

then I added #define DEBUG  to both head.S and decompress.c under
arm/boot/compressed.
I added earlyprintk to the cmdline args used by the kexec bootloader but nothing

That kernel does boot silently, just 'Uncompresing..' then
'XZ-compressed data is corrupt -- System halted'

I do have output from the Angel bootloader at 9600 and by the kernel
at 115200 so the uart is working...
Any hint?
Thanks
Andrea
