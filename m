From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Jan 2013 09:24:30 +0100
Subject: [PATCH 2/3] arm: sunxi: Add clock definitions for the new clock
 driver
In-Reply-To: <1358835176-7197-3-git-send-email-emilio@elopez.com.ar>
References: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
 <1358835176-7197-3-git-send-email-emilio@elopez.com.ar>
Message-ID: <5108D8BE.1080906@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

Le 22/01/2013 07:12, Emilio L?pez a ?crit :

> +		cpu: cpu at 01c20054 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sunxi-cpu-clk";
> +			reg = <0x01c20054 0x4>;
> +			clocks = <&osc32k>, <&osc24M>, <&pll1>;
> +		};

Why do you need these three clocks here ? From what you said in patch 3,
it seems like the 24M oscillator is not a direct parent, but only the
pll1 and the 32k oscillator, right?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
