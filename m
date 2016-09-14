From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Sep 2016 14:07:22 +0200
Subject: [PATCH V2 3/4] ARM64 LPC: support serial based on low-pin-count
In-Reply-To: <57D93921.50303@hisilicon.com>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
 <2531252.L41vzyMSKX@wuerfel> <57D93921.50303@hisilicon.com>
Message-ID: <13406676.rztgqQLiFa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 14, 2016 7:48:49 PM CEST zhichang.yuan wrote:
> On 2016/9/8 17:58, Arnd Bergmann wrote:
> > On Thursday, September 8, 2016 5:51:25 PM CEST zhichang wrote:
> >> On 2016?09?07? 22:50, Arnd Bergmann wrote:
> >>> On Wednesday, September 7, 2016 9:33:52 PM CEST Zhichang Yuan wrote:
> >>>> From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
> >>>>
> >>>> On Hip06 platform, a 16550 compatible UART is connected to low-pin-count and
> >>>> controlled through the LPC I/O cycles. This patch drives the UART port with
> >>>> the specific serial in/out function pair based on the indirect-IO mechanism
> >>>> introduced by Hip06 LPC driver.
> >>>>
> >>>> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> >>>
> >>> Any reason this cannot just use the regular drivers/tty/serial/8250/8250_of.c
> >>> driver?
> >> I think two reasons for that:
> >> 1. 8250_of.c is only for devicetree, but we need to support ACPI device too;
> > 
> > ACPI has its own way of describing serial ports, use that instead.
> Could you give me some info about ACPI serial ports?
> I found there is _CRS specific for serial, but it seems no serial driver use that.

drivers/tty/serial/8250/8250_dw.c is a driver that uses ACPI matching,
and possibly drivers/tty/serial/8250/8250_pnp.c could work as well.

	Arnd
