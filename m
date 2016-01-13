From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 13 Jan 2016 15:59:51 +0100
Subject: [PATCH v12 0/18] Add Analogix Core Display Port Driver
In-Reply-To: <1450873538-18304-1-git-send-email-ykk@rock-chips.com>
References: <1450873538-18304-1-git-send-email-ykk@rock-chips.com>
Message-ID: <2322926.s1viZ6tSS3@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

Am Mittwoch, 23. Dezember 2015, 20:25:38 schrieb Yakir Yang:
>    The Samsung Exynos eDP controller and Rockchip RK3288 eDP controller
> share the same IP, so a lot of parts can be re-used. I split the common
> code into bridge directory, then rk3288 and exynos only need to keep
> some platform code. Cause I can't find the exact IP name of exynos dp
> controller, so I decide to name dp core driver with "analogix" which I
> find in rk3288 eDP TRM

could you rebase your patches on top of Dave's drm-next branch [0] please?
The exynos part got some const attributes for the *_func_ops structs and 
drm_encoder_init got an additional parameter.
I'm still hoping that we can get this finally committed once 4.5-rc1 is 
released in 1.5 weeks :-) .

I did try to merge things together [1], the system at least comes up and 
detects the panel (EDID is read correctly and it turns the backlight on) but 
I don't see any output on the display - hdmi works fine though and X11 is 
claiming everything to be fine in both cases.

So I don't know yet if I made a mistake when putting this together or there 
is an issue on the driver-side.


Thanks
Heiko


[0] http://cgit.freedesktop.org/~airlied/linux/log/?h=drm-next
[1] https://github.com/mmind/linux-rockchip/tree/tmp/analogixdp_v12-veyron
I left out patch16, per your talk with Jingoo and me not seeing any AUX CH 
errors without it.
