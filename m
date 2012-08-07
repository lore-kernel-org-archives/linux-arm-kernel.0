From: Dongjin.Kim@agreeyamobility.net (Dongjin Kim)
Date: Tue, 7 Aug 2012 07:28:02 +0000
Subject: [PATCH] ARM: EXYNOS: Add HDMIPHY I2C adaptor
In-Reply-To: <CAK9yfHz_q22JgkULR9V8bR5W_TXVRn5qs5u2MiJJpa-Br_YQUQ@mail.gmail.com>
References: <1344261462-14183-1-git-send-email-dongjin.kim@agreeyamobility.net>
 <1344261462-14183-2-git-send-email-dongjin.kim@agreeyamobility.net>,
 <CAK9yfHz_q22JgkULR9V8bR5W_TXVRn5qs5u2MiJJpa-Br_YQUQ@mail.gmail.com>
Message-ID: <b937n0skj9tqmbg6tctdu48x.1344324481459@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

Thanks for your feedback, I couldnt find the patch series eariler. ;)

Regards,
Dongjin.

Sent from Moxier Mail
(http://www.moxier.com)


----- ?? ??? -----
?? ??:Sachin Kamat <sachin.kamat@linaro.org>
?? ??:Dongjin Kim <tobetter@gmail.com>
??:Dongjin Kim <Dongjin.Kim@agreeyamobility.net>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel at lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc at vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel at vger.kernel.org" <linux-kernel@vger.kernel.org>
?? ??:2012. 8. 7. 3:57 ??
??:Re: [PATCH] ARM: EXYNOS: Add HDMIPHY I2C adaptor



Hi Dongjin,

A patch series to add HDMI platform data support is already under consideration.

http://comments.gmane.org/gmane.linux.kernel.samsung-soc/11352



On 6 August 2012 19:27, Dongjin Kim <tobetter@gmail.com> wrote:
> This patch assign the I2C channel for HDMIPHY for Exynos4x12
> in s5p_i2c_hdmiphy_set_platdata() and s5p_hdmi_set_platdata()
>
> Change-Id: I7e66c8f9327e2f7dce7440efb8583b506d65831a
> Signed-off-by: Dongjin Kim <dongjin.kim@agreeyamobility.net>
> ---
>  arch/arm/plat-samsung/devs.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> index a199e55..54614d0 100644
> --- a/arch/arm/plat-samsung/devs.c
> +++ b/arch/arm/plat-samsung/devs.c
> @@ -752,6 +752,8 @@ void __init s5p_i2c_hdmiphy_set_platdata(struct s3c2410_platform_i2c *pd)
>
>                 if (soc_is_exynos4210())
>                         pd->bus_num = 8;
> +               else if (soc_is_exynos4212() || soc_is_exynos4412())
> +                       pd->bus_num = 8;
>                 else if (soc_is_s5pv210())
>                         pd->bus_num = 3;
>                 else
> @@ -771,6 +773,8 @@ void __init s5p_hdmi_set_platdata(struct i2c_board_info *hdmiphy_info,
>
>         if (soc_is_exynos4210())
>                 pd->hdmiphy_bus = 8;
> +       else if (soc_is_exynos4212() || soc_is_exynos4412())
> +               pd->hdmiphy_bus = 8;
>         else if (soc_is_s5pv210())
>                 pd->hdmiphy_bus = 3;
>         else
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--
With warm regards,
Sachin
