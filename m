From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 15 Jan 2015 09:14:23 +0100
Subject: [PATCH 2/2] clk: exynos-audss: Fix memory leak on driver unbind or
 probe failure
In-Reply-To: <20150114222504.22722.49023@quantum>
References: <1420451561-12360-1-git-send-email-k.kozlowski@samsung.com>
 <1420451561-12360-2-git-send-email-k.kozlowski@samsung.com>
 <54AEF541.1090700@codeaurora.org> <20150114222504.22722.49023@quantum>
Message-ID: <1421309663.12511.2.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2015-01-14 at 14:25 -0800, Mike Turquette wrote:
> Quoting Stephen Boyd (2015-01-08 13:23:13)
> > On 01/05/2015 01:52 AM, Krzysztof Kozlowski wrote:
> > > The memory allocated by basic clock divider/gate/mux (struct clk_gate,
> > > clk_divider and clk_mux) was leaking. During driver unbind or probe
> > > failure the driver only unregistered the clocks.
> > >
> > > Use clk_unregister_{gate,divider,mux} to release all resources.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > >
> > 
> > Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> I've applied both patches to clk-next. Krzysztof, let me know if you
> would prefer to take the audss patch through the samsung clock branch
> instead (to include it in a later pull request).

Thanks! I'm fine with applying them to clk-next.

Best regards,
Krzysztof


> 
> Regards,
> Mike
> 
> > 
> > -- 
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> > 
