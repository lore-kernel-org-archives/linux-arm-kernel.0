From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 30 Jan 2012 21:21:41 +0100
Subject: [PATCH] cpufreq: Add S3C2416/S3C2450 cpufreq driver
In-Reply-To: <201201142209.58453.heiko@sntech.de>
References: <201201142209.58453.heiko@sntech.de>
Message-ID: <201201302121.42020.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag 14 Januar 2012, 22:09:57 schrieb Heiko St?bner:
> The S3C2416/S3C2450 SoCs support two sources for the armclk.
> 
> The first source is the so called armdiv which divides the msysclk down
> to provide necessary cpu rates. In this mode the core voltage must be
> always at 1.3V. The frequency from the armdiv is not allowed to be
> lower than the hclk frequency.
> 
> In the second mode the armclk can be sourced directly from the hclk in
> the so called "dynamic voltags scaling" (dvs) mode. Here the armdiv
> isn't used at all. Also in this mode the core voltage may be lowered.
> Existing hardware and tests with it suggest 1.0V as sufficient.
> 
> When changing the clock source to the armdiv from the hclk, the SoC
> shows stability issues if the new frequency is higher than the current
> hclk frequency. Hence the driver always forces the armdiv to the hclk
> frequency before the source change and lets the cpufreq issue another
> set_target call for higher frequencies.
> 
> To mark the hclk frequency as lower as the corresponding armdiv
> frequency it is set 1MHz below the real frequency. This lets the cpufreq
> framework change between 133MHz based on hclk and 133MHz based on armdiv
> at will.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
ping?

Thanks
Heiko
