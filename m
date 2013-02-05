From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Tue, 5 Feb 2013 11:06:08 +0530
Subject: [PATCH v5 09/10] clk: tegra: Implement clocks for Tegra114
In-Reply-To: <20130204143401.GW2364@tbergstrom-lnx.Nvidia.com>
References: <1359713962-16822-1-git-send-email-pdeschrijver@nvidia.com>
 <1359713962-16822-10-git-send-email-pdeschrijver@nvidia.com>
 <510F5E87.90801@nvidia.com> <20130204143401.GW2364@tbergstrom-lnx.Nvidia.com>
Message-ID: <51109A48.5000708@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 February 2013 08:04 PM, Peter De Schrijver wrote:
> On Mon, Feb 04, 2013 at 08:08:55AM +0100, Prashant Gaikwad wrote:
>> On Friday 01 February 2013 03:48 PM, Peter De Schrijver wrote:
> ...
>
>>> +       /* xusb_hs_src */
>>> +       val = readl(clk_base + CLK_SOURCE_XUSB_SS_SRC);
>>> +       val |= BIT(25); /* always select PLLU_60M */
>>> +       writel(val, clk_base + CLK_SOURCE_XUSB_SS_SRC);
>>> +
>>> +       clk = clk_register_fixed_factor(NULL, "xusb_hs_src", "pll_u_60M", 0,
>>> +                                       1, 1);
>>> +       clks[xusb_hs_src] = clk;
>>> +
>> With device tree we can directly use pll_u_60M, no need to register
>> clock with fixed factor 1.
>> Same comment for dis1-fixed, dsi2-fixed and mipi-cal-fast clocks.
>>
> Does it make sense to have separate DT IDs at all then?

We can use same DT ID.

> Cheers,
>
> Peter.
