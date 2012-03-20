From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Mar 2012 20:18:12 -0600
Subject: [PATCH v4 05/10] ARM: tegra: Provide clock for only one PWM
 controller
In-Reply-To: <1331740593-10807-6-git-send-email-thierry.reding@avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-6-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F67E8E4.7000604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2012 09:56 AM, Thierry Reding wrote:
> A subsequent patch will add a generic PWM API driver for the Tegra PWFM
> controller, supporting all four PWM devices with a single PWM chip. The
> device will be named tegra-pwm and only one clock needs to be provided.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Acked-by: Stephen Warren <swarren@nvidia.com>
...
> -	CLK_DUPLICATE("pwm", "tegra_pwm.0", NULL),
> -	CLK_DUPLICATE("pwm", "tegra_pwm.1", NULL),
> -	CLK_DUPLICATE("pwm", "tegra_pwm.2", NULL),
> -	CLK_DUPLICATE("pwm", "tegra_pwm.3", NULL),
> +	CLK_DUPLICATE("pwm", "tegra-pwm", NULL),

I thought harder about this: Why not delete /all/ the CLK_DUPLICATE()s
for PWM, and change the second parameter to PERIPH_CLK for PWM from
"pwm" to "tegra-pwm"?
