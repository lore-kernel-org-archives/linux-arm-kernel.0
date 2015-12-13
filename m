From: greg@kroah.com (Greg Kroah-Hartman)
Date: Sat, 12 Dec 2015 22:06:43 -0800
Subject: [PATCH] tty: amba-pl011: add support for 32-bit register access
 for earlycon
In-Reply-To: <1446855503-25881-1-git-send-email-timur@codeaurora.org>
References: <1446855503-25881-1-git-send-email-timur@codeaurora.org>
Message-ID: <20151213060643.GA30667@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 06:18:23PM -0600, Timur Tabi wrote:
> Add support the "mmio32" earlycon option for the pl011 device.  If
> specified in the earlycon parameter, all reads/writes to pl011 registers
> during early console will use 32-bit accessors.  Normally the function
> uses 8-bit writes.
> 
> Normal console uses the "access_32b" field of the vendor data structure
> to determine whether the registers needs 32-bit accessors.  Early console
> is used before the vendor data is available, so we need a different
> mechanism to choose the accessor.
> 
> Example:
> 
> 	earlycon=pl011,mmio32,0x3ced1000
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
> 
> This patch applies on top of Russell's 12-part amba-pl011.c patchset.

Which I didn't apply, so can you resend this after he resends his?

thanks,

greg k-h
