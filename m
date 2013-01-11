From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 Jan 2013 21:28:46 +0800
Subject: i.MX6 kernel uncompress: how to output uncompress messages?
In-Reply-To: <50F00C6B.5000105@de.bosch.com>
References: <50F00C6B.5000105@de.bosch.com>
Message-ID: <20130111132845.GA24554@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dirk,

On Fri, Jan 11, 2013 at 01:58:19PM +0100, Dirk Behme wrote:
> Hi,
> 
> using an older, non-multiplatform kernel which still uses
> 
> arch/arm/mach-imx/include/mach/uncompress.h
> 
> I wonder how the uncompress is supposed to set the 'uart_base' for i.MX6?
> 
> Looking in
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-imx/include/mach/uncompress.h;h=477971b009308a929c53c19ce40c4b35c425d623;hb=69ac71d370b21cc52a2afd06f3a6d6d1da5edc75#l70
> 
> there doesn't seem to be any i.MX6 related case part?
> 
> This results in no
> 
> Uncompressing Linux... done, booting the kernle.
> 
> messages output on i.MX6. And with this the associated error
> messages in case anything goes wrong with the uncompression aren't
> output, either.
> 
> Adding a hack like
> 
> uart_base = MX6Q_UART4_BASE_ADDR;
> 
> outputs these uncompression messages.
> 
> What's the supposed clean way to do this?
> 
Please check this [1] out.  I plan send it for 3.9.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/205000
