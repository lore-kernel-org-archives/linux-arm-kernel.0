From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 6 Aug 2011 09:31:14 +0100
Subject: [PATCH 8/9] ARM: platform_device: pdev_archdata: add omap_device
	pointer
In-Reply-To: <1312589965-19416-9-git-send-email-khilman@ti.com>
References: <1312589965-19416-1-git-send-email-khilman@ti.com>
	<1312589965-19416-9-git-send-email-khilman@ti.com>
Message-ID: <CACxGe6sJsvPTS_+T9mYHVeG7GmXOq-KBqX+FdNiFrbnfaXa1pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 6, 2011 at 1:19 AM, Kevin Hilman <khilman@ti.com> wrote:
> Add omap_device pointer to the ARM-specific arch data in the
> platform_device. ?This will be used to attach OMAP-specific
> device-data to the platform device with device lifetime.
>
> Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> ?arch/arm/include/asm/device.h | ? ?5 +++++
> ?1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
> index 9f390ce..b5c9f5b 100644
> --- a/arch/arm/include/asm/device.h
> +++ b/arch/arm/include/asm/device.h
> @@ -12,7 +12,12 @@ struct dev_archdata {
> ?#endif
> ?};
>
> +struct omap_device;
> +
> ?struct pdev_archdata {
> +#ifdef CONFIG_ARCH_OMAP
> + ? ? ? struct omap_device *od;
> +#endif
> ?};
>
> ?#endif
> --
> 1.7.6
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
