From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 1 Mar 2013 23:52:01 +0100
Subject: [PATCH 0/2] gpio/omap: updates for v3.10
In-Reply-To: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
Message-ID: <CABxcv=nvZNWDgKLwQ6RPJyMdsAF5zVpo8dEhvE4YVZETiScDcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 1, 2013 at 6:22 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> Summary of updates:
> - Convert OMAP GPIO driver to use linear mapping for IRQ domains
> - Avoid crashes seen if a gpio bank is not enabled when requesting an IRQ.
>
> Testing includes:
> - Boot testing on OMAP5912 OSK, OMAP2420 H4, OMAP3430 SDP, OMAP4430 SDP
>   and AM335x EVM.
> - Verified that GPIO interrupts are working on OMAP5912 OSK, OMAP2420 H4,
>   OMAP3430 SDP and OMAP4430 SDP by making sure networking was working
>   correctly as these boards use a GPIO with the ethernet chips. Also
>   checked /proc/interrupts to ensure GPIO interrupt counts are
>   incrementing as expected.
>
> Jon Hunter (2):
>   gpio/omap: convert gpio irq domain to linear mapping
>   gpio/omap: warn if bank is not enabled on setting irq type
>
>  drivers/gpio/gpio-omap.c |   75 +++++++++++++++++++++-------------------------
>  1 file changed, 34 insertions(+), 41 deletions(-)
>
> --

I've tested on a TI OMAP3 DM3735 board (IGEPv2) and the ethernet chip
(which use a GPIO line as a IRQ) is working correctly too.

So, for both patches:

Tested-by: Javier Martinez Canillas <javier@dowhile0.org>
