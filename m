From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Sep 2016 14:25:54 +0200
Subject: [PATCH V3 3/4] ARM64 LPC: support serial based on low-pin-count
In-Reply-To: <1473855354-150093-4-git-send-email-yuanzhichang@hisilicon.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <1473855354-150093-4-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <4340181.AghlmQIy28@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 14, 2016 8:15:53 PM CEST Zhichang Yuan wrote:
> From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
> 
> On Hip06 platform, a 16550 compatible UART is connected to low-pin-count and
> controlled through the LPC I/O cycles. After registering the LPC uart specific
> serial_in/serial_out to 8250 core driver, serial data can be read/written
> through the LPC.
> 
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> 

I still think this should be handled by 8250_of.c after the addition of
support for IORESOURCE_IO.

	Arnd
