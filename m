From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 31 Oct 2013 17:41:42 +0200
Subject: [PATCH] clk: tegra: use pll_ref as the pll_e parent
In-Reply-To: <52718D1B.6030106@wwwdotorg.org>
References: <1383093707-10312-1-git-send-email-pdeschrijver@nvidia.com>
 <527128B5.2020101@wwwdotorg.org>
 <20131030221833.GQ22111@tbergstrom-lnx.Nvidia.com>
 <52718D1B.6030106@wwwdotorg.org>
Message-ID: <20131031154142.GX22111@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 11:50:03PM +0100, Stephen Warren wrote:
> On 10/30/2013 04:18 PM, Peter De Schrijver wrote:
> > On Wed, Oct 30, 2013 at 04:41:41PM +0100, Stephen Warren wrote:
> >> On 10/29/2013 06:41 PM, Peter De Schrijver wrote:
> >>> Use pll_ref instead of pll_re_vco as the pll_e parent on Tegra114 and
> >>> Tegra124. Also add a pll_ref table entry for pll_e for Tegra114.
> >>
> >> Why? What benefit does this give, or what bug does this fix?
> > 
> > Otherrwise Tegra114 will crash on boot.
> 
> Sigh. For what reason?

pll_re_vco having an unsupported rate of 300Mhz. My guess is that it depends
on the bootloader if you will see this. I'm fairly sure I verified this on
my dalmore in helsinki and it worked, but it failed on Paul's test setup.

Cheers,

Peter.
