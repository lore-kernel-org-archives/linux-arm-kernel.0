From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Feb 2016 13:53:26 -0800
Subject: [PATCH] ARM: dts: omap3-n900: Allow gpio keys to be disabled
In-Reply-To: <1452447990-22775-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1452447990-22775-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <20160212215326.GD19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160110 09:47]:
> Add linux,can-disable; to all gpios exported from gpio-keys driver, so
> userspace can disable them
...
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -68,6 +68,7 @@
>  			linux,input-type = <EV_SW>;
>  			linux,code = <SW_CAMERA_LENS_COVER>;
>  			gpio-key,wakeup;
> +			linux,can-disable;
>  		};
>  
>  		camera_focus {

Looks like this no longer applies because of linux,can-disable
to wakeup-source changes. Can you please update against v4.5-rc
series and repost?

Thanks,

Tony
