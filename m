From: balbi@ti.com (Felipe Balbi)
Date: Mon, 21 Jan 2013 20:41:38 +0200
Subject: [PATCH 12/15] USB: gadget/freescale: disable non-multiplatform
 drivers
In-Reply-To: <1358788568-11137-13-git-send-email-arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <1358788568-11137-13-git-send-email-arnd@arndb.de>
Message-ID: <20130121184138.GB10106@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 21, 2013 at 05:16:05PM +0000, Arnd Bergmann wrote:
> Both the fsl_mxc gadget and the imx_udc gadget drivers fail to build
> without the mach/hardware.h file that is not available when building
> for multiplatform. Let's disable these drivers for v3.8 in combination
> with CONFIG_ARCH_MULTIPLATFORM, and fix them properly in v3.9 unless
> someone has an better solution.
> 
> Without this patch, building allyesconfig results in:
> 
> drivers/usb/gadget/fsl_mxc_udc.c:21:27: fatal error: mach/hardware.h: No such file or directory
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb at vger.kernel.org

NAK, I prefer to see a real fix for the problem (which in fact is
already in my fixes branch).

Next time, before enabling something by default, check that
allyesconfig, allmodconfig and allnoconfig builds fine, please.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130121/e2036f1b/attachment.sig>
