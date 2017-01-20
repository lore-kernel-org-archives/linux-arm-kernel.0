From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 20 Jan 2017 19:32:26 +0200
Subject: [PATCH 2/2] ARM: dts: exynos: Use correct mfc_pd async-bridge
 clock for Exynos5420
In-Reply-To: <55cdceb9-d768-d5a9-7bc2-d4ef26d2e5e8@osg.samsung.com>
References: <1484864995-10679-1-git-send-email-javier@osg.samsung.com>
 <1484864995-10679-2-git-send-email-javier@osg.samsung.com>
 <20170120162846.x766u3nzblqywggj@kozik-lap>
 <55cdceb9-d768-d5a9-7bc2-d4ef26d2e5e8@osg.samsung.com>
Message-ID: <20170120173226.vekg4xyt4aevwy43@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 02:15:40PM -0300, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 01/20/2017 01:28 PM, Krzysztof Kozlowski wrote:
> > On Thu, Jan 19, 2017 at 07:29:55PM -0300, Javier Martinez Canillas wrote:
> >> Commit 94aed538e032 ("ARM: dts: exynos: Add async-bridge clock to MFC
> >> power domain for Exynos5420") fixed an imprecise external abort error
> >> when the MFC registers were tried to be accessed and the needed clock
> >> for the asynchronous bridges were gated.
> >>
> >> But according to the Exynos5420 manual the "Gating AXI clock for MFC"
> >> is not CLK_ACLK333 but CLK_MFC.
> >>
> >> The end effect is the same because CLK_ACLK333 is a parent of CLK_MFC
> >> but the correct clock should be used instead.
> >>
> >> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> >>
> >> ---
> >>
> >>  arch/arm/boot/dts/exynos5420.dtsi | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Is this still needed?
> > 
> 
> Not really, only if we care about correctness in the existing power domains
> that have their clocks defined. But as said, even currently with CLK_ACLK333
> works due to the clock hierarchy.
> 
> I think is less of an issue now that we prefer to mark clocks that needs to
> be ungated as critical instead of growing the DT ABI.

Okay then, I'll skip the patch. Resend if it turns out to be needed.


Best regards,
Krzysztof
