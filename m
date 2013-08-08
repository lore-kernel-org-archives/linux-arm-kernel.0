From: russ.dill@gmail.com (Russ Dill)
Date: Thu, 8 Aug 2013 00:05:01 -0700
Subject: [PATCHv3 7/9] ARM: OMAP: omap_device: Add APIs to enable and idle
 hwmods
In-Reply-To: <1375811376-49985-8-git-send-email-d-gerlach@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-8-git-send-email-d-gerlach@ti.com>
Message-ID: <CA+Bv8XYJPp3h0KiSO_harin+3XTjpOHFE9xz9ZvAFZnnZntV1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 6, 2013 at 10:49 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>
> Needed to let the AM335x PM handle the IPs which need forced
> standby transition during every suspend-resume cycle when
> the corresponding driver is not compiled into the kernel.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Reviewed-by: Russ Dill <russ.dill@ti.com>

> ---
>  arch/arm/mach-omap2/omap_device.c |    8 ++++++++
>  arch/arm/mach-omap2/omap_device.h |    2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index 5cc9287..8cf63f6 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -219,6 +219,10 @@ static int _omap_device_enable_hwmods(struct omap_device *od)
>         return 0;
>  }
>
> +int omap_device_enable_hwmods(struct omap_device *od)
> +{
> +       return _omap_device_enable_hwmods(od);
> +}
>  /**
>   * _omap_device_idle_hwmods - call omap_hwmod_idle() on all hwmods
>   * @od: struct omap_device *od
> @@ -236,6 +240,10 @@ static int _omap_device_idle_hwmods(struct omap_device *od)
>         return 0;
>  }
>
> +int omap_device_idle_hwmods(struct omap_device *od)
> +{
> +       return _omap_device_idle_hwmods(od);
> +}
>  /* Public functions for use by core code */
>
>  /**
> diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
> index 17ca1ae..655ec35 100644
> --- a/arch/arm/mach-omap2/omap_device.h
> +++ b/arch/arm/mach-omap2/omap_device.h
> @@ -87,6 +87,8 @@ struct device *omap_device_get_by_hwmod_name(const char *oh_name);
>
>  /* OMAP PM interface */
>  int omap_device_get_context_loss_count(struct platform_device *pdev);
> +int omap_device_enable_hwmods(struct omap_device *od);
> +int omap_device_idle_hwmods(struct omap_device *od);
>
>  /* Other */
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
