From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Fri, 6 Mar 2015 17:43:16 +0000
Subject: [PATCH 05/10] ARM: s3c64xx: enable sparse IRQ support
In-Reply-To: <1425299763-4066822-6-git-send-email-arnd@arndb.de>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
 <1425299763-4066822-6-git-send-email-arnd@arndb.de>
Message-ID: <20150306174316.GA26692@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 01:35:58PM +0100, Arnd Bergmann wrote:
> This is another prerequisite for enabling multiplatform
> support, and it is the part I am least certain about.
> 
> I assume it will cause the extra boot message "Cannot
> allocate irq_descs @ IRQ%d, assuming pre-allocated" to
> be printed, but otherwise work ok. This definitely needs
> to be tested on real hardware to see if it works.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

This one appears to cause some problems with the IRQs on
Cragganmore, I need to look into it a bit more but it looks like
one of the PMICs can't allocate its IRQs:

[    0.961455] wm831x 1-0034: WM8311 revision C
[    0.965066] wm831x 1-0034: Failed to allocate IRQs: -17

And the CODEC can't request its IRQ:

[    4.252735] arizona spi0.1: WM5102 revision C
[    4.269763] arizona spi0.1: Failed to request primary IRQ 263: -22

Hopefully I can look into this a little more next week.

Thanks,
Charles
