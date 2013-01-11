From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 Jan 2013 10:53:12 +0800
Subject: [PATCH 0/3] arch_decomp_wdog cleanup
In-Reply-To: <alpine.LFD.2.02.1301101430200.6300@xanadu.home>
References: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
 <alpine.LFD.2.02.1301101430200.6300@xanadu.home>
Message-ID: <20130111025311.GD9139@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 02:32:30PM -0500, Nicolas Pitre wrote:
> On Thu, 10 Jan 2013, Shawn Guo wrote:
> 
> > All the arch_decomp_wdog related codes are there without any users,
> > since ARCH_HAS_DECOMP_WDOG is only used by lib/inflate.c which however
> > is not used by arch/arm/boot/compressed/decompress.c.
> 
> It is also worth mentioning that CONFIG_S3C_BOOT_WATCHDOG is not set 
> anywhere.
> 
Yeah, the commit log of patch #3 now looks like:

    Besides the fact that CONFIG_S3C_BOOT_WATCHDOG is defined nowhere, with
    ARCH_HAS_DECOMP_WDOG removed from arch/arm/boot/compressed/decompress.c,
    all the arch_decomp_wdog() related codes are not unused.  Remove them.

> For those 3 patches:
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
Thanks, Nico.

Shawn
