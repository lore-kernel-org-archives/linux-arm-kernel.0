From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 6 Nov 2015 08:50:46 +0530
Subject: [PATCH v3 0/2] thermal: mediatek: Add cpu power cooling model
In-Reply-To: <1446721761.4016.56.camel@mtksdaap41>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
 <20151028154449.GH3716@ubuntu>
 <1446461181.10039.28.camel@mtksdaap41>
 <20151102121034.GA3639@ubuntu>
 <1446721761.4016.56.camel@mtksdaap41>
Message-ID: <20151106032046.GK3773@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05-11-15, 19:09, dawei chien wrote:
> Thank you for your kindly explaining, now I could understand what I
> miss, I will send device tree binding on next version such like
> following description.
> 
> --- a/Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
> +++ b/Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
> @@ -10,6 +10,17 @@ Required properties:
>         Please refer to
> Documentation/devicetree/bindings/clk/clock-bindings.txt for
>         generic clock consumer properties.
>  - proc-supply: Regulator for Vproc of CPU cluster.
> +- dynamic-power-coefficient:
> +       Usage: optional
> +       Value type: <prop-encoded-array>
> +       Definition: A u32 value that represents an indicative
> +       running time dynamic power coefficient in
> +       fundamental units of mW/MHz/uVolt^2.
> +       The dynamic energy consumption of the CPU
> +       is proportional to the square of the
> +       Voltage (V) and the clock frequency (f).
> +       Pdyn = dynamic-power-coefficient * V^2 * f
> +       where voltage is in uV, frequency is in MHz.

Please check with Punit if he is planning to add the same..

> Thank you for your kindly explaining, Now I know I should develop and
> test on mainline branch since this is where I try to add code.
> 
> However, please understanding currently mt8173_cpufreq.c is not ready
> for OPPV2 in mainline as far, that's the reason why currently I can't
> reuse OPPV2 and extend for static power table. My propose is for adding
> CPU cooling device for our own product.

Firstly, we don't care. You are pushing something to mainline, you
have to get it tested someway on mainline.

Secondly, there are *almost* no changes required to the mtk cpufreq
driver for OPPV2. Just update your DT in a similar way it is done for
one of the exynos platforms and it should just work fine.

-- 
viresh
