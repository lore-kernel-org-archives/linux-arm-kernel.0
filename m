From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Sat, 5 Jan 2013 08:14:48 +0530
Subject: [PATCH 2/7] clk: tegra: Use common of_clk_init() function
In-Reply-To: <50E703A8.1080808@wwwdotorg.org>
References: <1357282858-2112-1-git-send-email-pgaikwad@nvidia.com>
 <1357282858-2112-2-git-send-email-pgaikwad@nvidia.com>
 <50E703A8.1080808@wwwdotorg.org>
Message-ID: <50E793A0.4020702@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 January 2013 10:00 PM, Stephen Warren wrote:
> On 01/04/2013 12:00 AM, Prashant Gaikwad wrote:
>> Use common of_clk_init() function for clocks initialization.
>>   drivers/clk/tegra/clk-tegra20.c |    3 ++-
>>   drivers/clk/tegra/clk-tegra30.c |    3 ++-
> Oh, so this series is written assuming that the Tegra CCF rework is
> already applied then? That makes the dependencies quite painful, since I
> think we'll end up with the following order being needed:
>
> 1) clk: Add composite clock type
>     -> This would usually go through the clk tree.
> 2) The Tegra CCF rework series
>     -> This must go through the Tegra tree due to lots of dependencies
>     and merge conflicts with other Tegra patches.
> 3) This series
>     -> This would usually go through the clk tree.
>
> Is it possible to re-order the dependencies as (1) (3) (2), so that Mike
> can apply (1) and (3) to the clock tree, then I can use the clk tree as
> the basis for a branch in the Tegra tree to apply (2) and all the other
> Tegra patches that will conflict with (2)?

If Mike approves the concept and implementation in (1) and (3) then I 
will repost (2) and (3) with dependencies re-ordered.
