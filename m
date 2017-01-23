From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 23 Jan 2017 16:40:46 +0100
Subject: [PATCH v4 2/9] ARM: dts: rockchip: update compatible property
 for rk3228 timer
In-Reply-To: <1480436092-10728-3-git-send-email-al.kochet@gmail.com>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
 <1480436092-10728-1-git-send-email-al.kochet@gmail.com>
 <1480436092-10728-3-git-send-email-al.kochet@gmail.com>
Message-ID: <20170123154046.GF2166@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 07:14:45PM +0300, Alexander Kochetkov wrote:
> Property set to '"rockchip,rk3228-timer", "rockchip,rk3288-timer"'
> to match devicetree bindings.
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  arch/arm/boot/dts/rk3228-evb.dts |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3228-evb.dts b/arch/arm/boot/dts/rk3228-evb.dts
> index 904668e..38eab87 100644
> --- a/arch/arm/boot/dts/rk3228-evb.dts
> +++ b/arch/arm/boot/dts/rk3228-evb.dts
> @@ -70,3 +70,7 @@
>  &uart2 {
>  	status = "okay";
>  };
> +
> +&timer {
> +	compatible = "rockchip,rk3228-timer", "rockchip,rk3288-timer";
> +};

I'm not sure this is correct, to which timer &timer will refer ?

        timer {
                compatible = "arm,armv7-timer";
		...
	}

        timer: timer at 110c0000 {
                compatible = "rockchip,rk3288-timer";
		...
	}

Why not change the compatible string in the timer definition in rk322x.dtsi ?

Same comment for the other patches doing these changes.

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
