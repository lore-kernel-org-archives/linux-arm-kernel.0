From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 01 Feb 2017 10:48:53 +0100
Subject: [PATCH v6 5/5] ARM: dts: rockchip: disable arm-global-timer for
 rk3188
In-Reply-To: <1485866596-32254-6-git-send-email-al.kochet@gmail.com>
References: <1485866596-32254-1-git-send-email-al.kochet@gmail.com>
 <1485866596-32254-6-git-send-email-al.kochet@gmail.com>
Message-ID: <2265306.UfJ65TkXez@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 31. Januar 2017, 15:43:16 CET schrieb Alexander Kochetkov:
> The clocksource and the sched_clock provided by the arm_global_timer
> are quite unstable because their rates depend on the cpu frequency.
> 
> On the other side, the arm_global_timer has a higher rating than the
> rockchip_timer, it will be selected by default by the time framework
> while we want to use the stable rockchip clocksource.
> 
> Let's disable the arm_global_timer in order to have the rockchip
> clocksource selected by default.
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>

depending on who is picking that up, they can add my
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

if needed.

Later on we might need to look at the rk3066 as well, as it might have the 
same issue.
