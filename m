From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 06 Aug 2018 10:10:15 +0200
Subject: [PATCH v0] clk: rockchip: Add pclk_rkpwm_pmu to PMU critical
 clocks in rk3399
In-Reply-To: <1533367862-7212-1-git-send-email-djw@t-chip.com.cn>
References: <1533367862-7212-1-git-send-email-djw@t-chip.com.cn>
Message-ID: <2499930.7n9Q7JauMx@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Levin,

Am Samstag, 4. August 2018, 09:31:02 CEST schrieb djw at t-chip.com.cn:
> From: Levin Du <djw@t-chip.com.cn>
> 
> PWM2 is commonly used to control voltage of PWM regulator of VDD_LOG in
> RK3399. On the Firefly-RK3399 board, PWM2 outputs 40 KHz square wave
> from power on and the VDD_LOG is about 0.9V. When the kernel boots
> normally into the system, the PWM2 keeps outputing PWM signal.
> 
> But the kernel hangs randomly after "Starting kernel ..." line on that
> board. When it happens, PWM2 outputs high level which causes VDD_LOG
> drops to 0.4V below the normal operating voltage.
> 
> By adding "pclk_rkpwm_pmu" to the rk3399_pmucru_critical_clocks array,
> PWM clock is ensured to be prepared at startup and the PWM2 output is
> normal. After repeated tests, the early boot hang is gone.
> 
> This patch works on both Firefly-RK3399 and ROC-RK3399-PC boards.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>

applied to my clk-branch

Thanks for tracking that down
Heiko
