From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 3 Mar 2013 02:08:49 +0100
Subject: [PATCH v6 01/16] clk: samsung: add common clock framework helper
 functions for Samsung platforms
In-Reply-To: <1361175686-19400-2-git-send-email-thomas.abraham@linaro.org>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
 <1361175686-19400-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <201303030208.49722.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Montag, 18. Februar 2013, 09:21:11 schrieb Thomas Abraham:
> All Samsung platforms include different types of clock including
> fixed-rate, mux, divider and gate clock types. There are typically
> hundreds of such clocks on each of the Samsung platforms. To enable
> Samsung platforms to register these clocks using the common clock
> framework, a bunch of utility functions are introduced here which simplify
> the clock registration process. The clocks are usually statically
> instantiated and registered with common clock framework.
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Tested-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

I'm playing around with this on my s3c2416 platform and it works like a charm 
for the most part - and the system already comes sort of up again :-) .

So,
Tested-by: Heiko Stuebner <heiko@sntech.de>


But is there an easy way to define more than one alias? On the s3c2416 for 
example the hsmmc hclk is the "hsmmc" io-clock, as well as the source for the 
"mmc_busclk.0". Same for the "uart" pclk, that is also a baud clock source.


Thanks
Heiko
