From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 24 Mar 2016 12:13:24 +0530
Subject: [PATCH v2] cpufreq: rockchip: add driver
In-Reply-To: <56F35894.3020106@rock-chips.com>
References: <1458647848-48999-1-git-send-email-xf@rock-chips.com>
 <1458699487-58470-1-git-send-email-xf@rock-chips.com>
 <20160323044033.GQ5272@vireshk-i7>
 <56F35894.3020106@rock-chips.com>
Message-ID: <20160324064324.GG22062@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24-03-16, 11:01, Feng Xiao wrote:
> hi all,
>      I found that it could match the cpufreq-dt driver succesfully only with
> the following changes.
> --- a/arch/arm64/boot/dts/rockchip/rk3366.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3366.dtsi
> @@ -139,6 +139,10 @@
>                 };
>         };
> 
> +       cpufreq-dt {   //the node name must be cpufreq-dt
> +               compatible = "rockchip,cpufreq";  //  the compatible name is
> insignificant
> +       };
> +

Its not allowed to create a DT node for a dummy device and so we never
followed this way.

I have just sent a patchset and cc'd you:
"[PATCH 0/3] cpufreq: dt: Create platform device from generic code"

and so this patch shall get replaced now.

-- 
viresh
