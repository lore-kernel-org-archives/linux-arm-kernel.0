From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 11 Jan 2013 13:58:19 +0100
Subject: i.MX6 kernel uncompress: how to output uncompress messages?
Message-ID: <50F00C6B.5000105@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

using an older, non-multiplatform kernel which still uses

arch/arm/mach-imx/include/mach/uncompress.h

I wonder how the uncompress is supposed to set the 'uart_base' for i.MX6?

Looking in

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-imx/include/mach/uncompress.h;h=477971b009308a929c53c19ce40c4b35c425d623;hb=69ac71d370b21cc52a2afd06f3a6d6d1da5edc75#l70

there doesn't seem to be any i.MX6 related case part?

This results in no

Uncompressing Linux... done, booting the kernle.

messages output on i.MX6. And with this the associated error messages in 
case anything goes wrong with the uncompression aren't output, either.

Adding a hack like

uart_base = MX6Q_UART4_BASE_ADDR;

outputs these uncompression messages.

What's the supposed clean way to do this?

Many thanks

Dirk
