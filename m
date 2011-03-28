From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 28 Mar 2011 17:13:00 +0800
Subject: [PATCHv3] ARM:boot:device tree: Allow the device tree binary
	to be appended to zImage
In-Reply-To: <20110324231830.2586.7150.stgit@riker>
References: <20110324231830.2586.7150.stgit@riker>
Message-ID: <20110328091259.GA18721@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2011 at 04:18:41PM -0700, John Bonesio wrote:
> This patch provides the ability to boot using a device tree that is appended
> to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
> 
> Signed-off-by: John Bonesio <bones@secretlab.ca>
> ---
> 
Tested on mx51 babbage.  The non-dt kernel works fine, but dt kernel
does not.

I tracked it down a little bit and found, before calling kernel from
arch/arm/boot/compressed/head.S, the dtb magic number (at address
pointed by r8) was interpolated to 0x73fbc000 which happens to be the
value of 'uart_base' assigned in plat-mxc/include/mach/uncompress.h.

-- 
Regards,
Shawn
