From: balbi@ti.com (Felipe Balbi)
Date: Mon, 21 Jan 2013 20:42:38 +0200
Subject: [PATCH 13/15] USB: ehci: make orion and mxc bus glues coexist
In-Reply-To: <1358788568-11137-14-git-send-email-arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <1358788568-11137-14-git-send-email-arnd@arndb.de>
Message-ID: <20130121184237.GC10106@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 05:16:06PM +0000, Arnd Bergmann wrote:
> In linux-3.8-rc1 it became possible to build the imx and
> mvebu platforms together in a single kernel, which clashes
> in the ehci driver.
> 
> Manjunath Goudar is already working on a patch to convert
> both the imx and the mvebu glue drivers (along with all
> the other ARM specific ones) to the new probing method,
> but that will be too late to fix v3.8. This patch instead
> adds yet another hack like the existing ones to allow
> the ehci driver to load both back-ends.
> 
> Without this patch, building allyesconfig results in:
> 
> drivers/usb/host/ehci-hcd.c:1285:0: error: "PLATFORM_DRIVER" redefined
> drivers/usb/host/ehci-hcd.c:1255:0: note: this is the location of the previous definition
> In file included from drivers/usb/host/ehci-hcd.c:1254:0:
> drivers/usb/host/ehci-mxc.c:280:31: warning: 'ehci_mxc_driver' defined but not used
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb at vger.kernel.org
> Cc: Manjunath Goudar <manjunath.goudar@linaro.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>

NAK, should be converted to the new usage of ehci library driver. Alan
Stern already implemented for a few drivers, help is very welcome.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130121/bb62631b/attachment-0001.sig>
