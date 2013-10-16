From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 16 Oct 2013 10:38:27 +0300
Subject: [PATCH v3 13/19] clk: tegra: introduce common gen4 super clock
In-Reply-To: <525D9973.2070501@wwwdotorg.org>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
 <1381848794-11761-14-git-send-email-pdeschrijver@nvidia.com>
 <525D9973.2070501@wwwdotorg.org>
Message-ID: <20131016073827.GC5643@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 09:37:23PM +0200, Stephen Warren wrote:
> On 10/15/2013 08:52 AM, Peter De Schrijver wrote:
> > Introduce a common function which super clock initialization for Tegra114
> > and beyond.
> 
> Nit: s/which/{which,that} performs/ ?
> 
> For my education, why are cclk_g, cclk_lp, pll_x related to the super
> clock? I thought sclk/hclk/pclk were bus clocks, not something related
> to the CPU clock(s).

sclk (at least from tegra30 onwards) uses the same 'super clock' structure
than the CPU clocks. hclk and pclk are derived from that. Hence I considered
it sensible to define all of them in the same file.

Cheers,

Peter.
