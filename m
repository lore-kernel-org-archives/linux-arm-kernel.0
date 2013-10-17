From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 17 Oct 2013 10:52:34 +0300
Subject: [PATCH v3 00/19] Introduce common infra for tegra clocks
In-Reply-To: <525EC973.7060802@wwwdotorg.org>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
 <525D8009.5040907@wwwdotorg.org>
 <20131016090643.GI5643@tbergstrom-lnx.Nvidia.com>
 <525EC973.7060802@wwwdotorg.org>
Message-ID: <20131017075233.GP5643@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 07:14:27PM +0200, Stephen Warren wrote:
> On 10/16/2013 03:06 AM, Peter De Schrijver wrote:
> > On Tue, Oct 15, 2013 at 07:48:57PM +0200, Stephen Warren wrote:
> >> On 10/15/2013 08:52 AM, Peter De Schrijver wrote:
> >>> This patchset introduces common infrastructure for clocks which exist in                                                                                       
> >>> several Tegra SoCs. We also also move Tegra20, Tegra30 and Tegra114 to
> >>> this new infrastructure.
> ...
> >> Testing on Venice2 (Tegra124): I see the following WARN during boot,
> >> which I think is new relative to the internal branch you gave me yesterday:
> >>
> >>> [    0.300450] WARNING: CPU: 0 PID: 1 at drivers/clk/tegra/clk.c:187 tegra_init_from_table+0x78/0x158()
> ...
> >>> [    0.372440] [<c07b4c1c>] (tegra_init_from_table+0x78/0x158) from [<c07b4e10>] (tegra_clocks_apply_init_table+0x18/0x20)
> >>> [    0.384138] [<c07b4e10>] (tegra_clocks_apply_init_table+0x18/0x20) from [<c079f9cc>] (tegra_dt_init+0xc/0xd8)
> >>> [    0.394903] [<c079f9cc>] (tegra_dt_init+0xc/0xd8) from [<c079a580>] (customize_machine+0x1c/0x40)
> ...
> > Did you see  'tegra_init_from_table: Failed to set parent pll_c2 of epp ' before? Tegra124 doesn't have EPP...
> 
> Yes, I get exactly that message. Sorry, I forgot to paste in the most
> relevant line:-( I assume fixing this simply means removing an entry in
> the init table in clk-tegra124.c, so should be simple.

Yep. Part of the next version.
