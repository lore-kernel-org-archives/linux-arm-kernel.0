From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 22 Dec 2010 10:21:14 -0700 (MST)
Subject: [PATCH v2 8/8] OMAP4: clock data: Add missing fixed divisors
In-Reply-To: <1291932820-11163-9-git-send-email-b-cousson@ti.com>
References: <1291932820-11163-1-git-send-email-b-cousson@ti.com>
	<1291932820-11163-9-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1012221019440.21915@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Dec 2010, Benoit Cousson wrote:

> From: Jon Hunter <jon-hunter@ti.com>
> 
> The following OMAP4 clocks have the following fixed divisors that
> determine the frequency at which these clocks operate. These
> dividers are defined by the PRCM specification and without these
> dividers the rates of the below clocks are calculated incorrectly.
> This may cause internal peripherals using these clocks to operate
> at the wrong frequency.
> 
> - abe_24m_fclk (freq = divided-by-8)
> - ddrphy_ck (freq = parent divided-by-2)
> - dll_clk_div_ck (freq = parent divided-by-2)
> - per_hs_clk_div_ck (freq = parent divided-by-2)
> - usb_hs_clk_div_ck (freq = parent divided-by-3)
> - func_12m_fclk (freq = parent divided-by-16)
> - func_24m_clk (freq = parent divided-by-4)
> - func_24mc_fclk (freq = parent divided-by-8)
> - func_48mc_fclk (freq = divided-by-4)
> - lp_clk_div_ck (freq = divided-by-16)
> - per_abe_24m_fclk (freq = divided-by-4)
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>

Beno?t just mentioned that I missed this one too, probably since it was 
posted after I had already pulled the v1 patches into a local branch.  
I'll add this one also, re-test on OMAP4, and post a new pull request.


- Paul
