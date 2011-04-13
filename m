From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Apr 2011 17:00:30 +0300
Subject: [PATCHv3] ARM:boot:device tree: Allow the device tree binary
	to be appended to zImage
In-Reply-To: <20110328091259.GA18721@S2100-06.ap.freescale.net>
References: <20110324231830.2586.7150.stgit@riker>
	<20110328091259.GA18721@S2100-06.ap.freescale.net>
Message-ID: <20110413140030.GE12665@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo <shawn.guo@freescale.com> [110328 12:10]:
> On Thu, Mar 24, 2011 at 04:18:41PM -0700, John Bonesio wrote:
> > This patch provides the ability to boot using a device tree that is appended
> > to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
> > 
> > Signed-off-by: John Bonesio <bones@secretlab.ca>
> > ---
> > 
> Tested on mx51 babbage.  The non-dt kernel works fine, but dt kernel
> does not.
> 
> I tracked it down a little bit and found, before calling kernel from
> arch/arm/boot/compressed/head.S, the dtb magic number (at address
> pointed by r8) was interpolated to 0x73fbc000 which happens to be the
> value of 'uart_base' assigned in plat-mxc/include/mach/uncompress.h.

Gave this a try on an omap3 based board, looks like decompress_kernel
will trash the first 16 bytes of the device tree data somehow.

John, can you please check if your current patch works properly?

Regards,

Tony
