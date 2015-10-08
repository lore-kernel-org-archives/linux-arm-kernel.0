From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 8 Oct 2015 17:50:15 +0200
Subject: [PATCH] arm: rpi: Device tree modifications for U-Boot
In-Reply-To: <1439303153-12171-1-git-send-email-sjg@chromium.org>
References: <1439303153-12171-1-git-send-email-sjg@chromium.org>
Message-ID: <20151008155015.GC11776@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> This updates the device tree from the kernel version to something suitable
> for U-Boot:
> 
> - Add stdout-path alias for console
> - Mark the /soc node to be available pre-relocation so that the early
> serial console works (we need the 'ranges' property to be available)
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  arch/arm/boot/dts/bcm2835.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> @@ -16,6 +17,7 @@
>  		#size-cells = <1>;
>  		ranges = <0x7e000000 0x20000000 0x02000000>;
>  		dma-ranges = <0x40000000 0x00000000 0x20000000>;
> +		u-boot,dm-pre-reloc;
>

Given low ammount of memory available for SPL, such stuff is going to be neccessary.

Should it have more generic name... "critical-for-early-boot" ?

Best regards,
									Pavel
