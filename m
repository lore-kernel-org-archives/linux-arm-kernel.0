From: tony@atomide.com (Tony Lindgren)
Date: Tue, 24 Apr 2012 09:37:34 -0700
Subject: [PATCH 06/19] ARM: OMAP4: Auto generate SAR layout contents
In-Reply-To: <1334914432-26456-7-git-send-email-t-kristo@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-7-git-send-email-t-kristo@ti.com>
Message-ID: <20120424163734.GM3739@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [120420 02:38]:
> -void omap4_sar_overwrite(void)
> +void omap_sar_overwrite(void)
>  {
>  	u32 val = 0;
> -	u32 offset = 0;
> +	u32 usb_offset = 0x2ec;
> +	u32 usb_offset2 = 0x91c;
>  
> -	if (cpu_is_omap446x())
> -		offset = 0x04;
> +	if (cpu_is_omap446x()) {
> +		usb_offset = 0x2f4;
> +		usb_offset2 = 0x920;
> +	}

Here too you should initialized these during __init. Otherwise
we'll end up piling more and more if else cpu_is_omapxxxx for
future omaps that again might change the offsets.

Tony
