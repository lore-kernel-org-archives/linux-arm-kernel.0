From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Mon, 23 Jan 2017 19:13:06 +0300
Subject: [PATCH v4 2/9] ARM: dts: rockchip: update compatible property for
 rk3228 timer
In-Reply-To: <20170123154046.GF2166@mai>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
 <1480436092-10728-1-git-send-email-al.kochet@gmail.com>
 <1480436092-10728-3-git-send-email-al.kochet@gmail.com>
 <20170123154046.GF2166@mai>
Message-ID: <FD75C944-4CE5-4393-8E49-79E47101D77F@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Daniel!

:
> +
> +&timer {
> +	compatible = "rockchip,rk3228-timer", "rockchip,rk3288-timer";
> +};

> 23 ???. 2017 ?., ? 18:40, Daniel Lezcano <daniel.lezcano@linaro.org> ???????(?):
> 
> I'm not sure this is correct, to which timer &timer will refer ?
> 
>        timer {
>                compatible = "arm,armv7-timer";
> 		...
> 	}
> 
>        timer: timer at 110c0000 {
>                compatible = "rockchip,rk3288-timer";
> 		...
> 	}

The block '&timer { ?}' change compatible string for 'timer: timer at 110c0000? timer'. It refers to it using ?timer:? label.
'arm,armv7-timer? has ?timer? node name without label and cannot be addressed in underline dts files.

> Why not change the compatible string in the timer definition in rk322x.dtsi ?

Initially my patch series was for rk3188 only. I declared rk3188 timer using rk3228 compatible string[1].
Heiko reviewed the series and suggest[2] to use another ?compatible=? binding for rk3188. And
suggest[3] to update rockchip,rk-timer.txt bindings, like mmc/rockchip-dw-mshc.txt does.
So I updated rockchip,rk-timer.txt. rk322x family has has two parts rk3228 and rk3229. So I replaced
rk322x to rk3228 and rk3229 and updated dts file to match bindings.

[1] http://lists.infradead.org/pipermail/linux-rockchip/2016-November/013152.html
[2] http://lists.infradead.org/pipermail/linux-rockchip/2016-November/013174.html
[3] http://lists.infradead.org/pipermail/linux-rockchip/2016-November/013174.html

> Same comment for the other patches doing these changes.
> 
>  -- Daniel
