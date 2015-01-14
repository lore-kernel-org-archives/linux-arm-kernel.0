From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 14 Jan 2015 14:25:04 -0800
Subject: [PATCH 2/2] clk: exynos-audss: Fix memory leak on driver unbind
 or probe failure
In-Reply-To: <54AEF541.1090700@codeaurora.org>
References: <1420451561-12360-1-git-send-email-k.kozlowski@samsung.com>
 <1420451561-12360-2-git-send-email-k.kozlowski@samsung.com>
 <54AEF541.1090700@codeaurora.org>
Message-ID: <20150114222504.22722.49023@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2015-01-08 13:23:13)
> On 01/05/2015 01:52 AM, Krzysztof Kozlowski wrote:
> > The memory allocated by basic clock divider/gate/mux (struct clk_gate,
> > clk_divider and clk_mux) was leaking. During driver unbind or probe
> > failure the driver only unregistered the clocks.
> >
> > Use clk_unregister_{gate,divider,mux} to release all resources.
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

I've applied both patches to clk-next. Krzysztof, let me know if you
would prefer to take the audss patch through the samsung clock branch
instead (to include it in a later pull request).

Regards,
Mike

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
