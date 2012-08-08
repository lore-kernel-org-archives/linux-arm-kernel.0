From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 Aug 2012 06:48:50 -0700
Subject: [PATCH v3 2/7] mfd: omap: control: core system control driver
In-Reply-To: <4FEB4B46.9020904@dev.rtsoft.ru>
References: <4FEB4B46.9020904@dev.rtsoft.ru>
Message-ID: <20120808134849.GC11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120627 11:09]:
> +
> +/* TODO: Add helpers for 16bit and byte access */
> +#ifdef CONFIG_MFD_OMAP_CONTROL
> +u32 omap_control_status_read(u16 offset);
> +#else
> +static inline u32 omap_control_status_read(u16 offset)
> +{
> +	return 0;
> +}
> +#endif

This should be an exported function instead. And it should
not need the offset as a parameter as the SCM core should know
where to find it's control_status register.

Regards,

Tony
