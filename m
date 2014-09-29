From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 29 Sep 2014 09:39:23 -0400 (EDT)
Subject: [PATCH] USB: host: st: fix ehci/ohci driver selection
In-Reply-To: <2536929.C0XC0THfdJ@wuerfel>
Message-ID: <Pine.LNX.4.44L0.1409290937260.14146-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Sep 2014, Arnd Bergmann wrote:

> The newly added sti ehci and ohci drivers come with a single
> Kconfig entry that does not depend on either of the base drivers,
> which leads to a link error when they are disabled:
> 
> drivers/built-in.o: In function `ohci_platform_init':
> :(.init.text+0x14788): undefined reference to `ohci_init_driver'
> 
> To fix that, this patch introduces two separate Kconfig options
> with proper dependencies, which avoids the problem and is also
> more consistent with the other glue drivers.

Not to mention that the patch places the new Kconfig options inside the 
appropriate "if" blocks.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: d115837259ada ("usb: host: ohci-st: Add OHCI driver support for ST STB devices")
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb at vger.kernel.org

Acked-by: Alan Stern <stern@rowland.harvard.edu>
