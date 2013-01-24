From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 24 Jan 2013 11:32:37 -0800
Subject: [PATCH 2/7] clk: tegra: Use common of_clk_init() function
In-Reply-To: <20130124192043.10623.60751@quantum>
References: <1357282858-2112-1-git-send-email-pgaikwad@nvidia.com>
 <1357282858-2112-2-git-send-email-pgaikwad@nvidia.com>
 <50E703A8.1080808@wwwdotorg.org> <50E793A0.4020702@nvidia.com>
 <20130124192043.10623.60751@quantum>
Message-ID: <51018C55.6000709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2013 11:20 AM, Mike Turquette wrote:
> Quoting Prashant Gaikwad (2013-01-04 18:44:48)
>> On Friday 04 January 2013 10:00 PM, Stephen Warren wrote:
>>> On 01/04/2013 12:00 AM, Prashant Gaikwad wrote:
>>>> Use common of_clk_init() function for clocks initialization.
>>>>   drivers/clk/tegra/clk-tegra20.c |    3 ++-
>>>>   drivers/clk/tegra/clk-tegra30.c |    3 ++-
>>> Oh, so this series is written assuming that the Tegra CCF rework is
>>> already applied then? That makes the dependencies quite painful, since I
>>> think we'll end up with the following order being needed:
>>>
>>> 1) clk: Add composite clock type
>>>     -> This would usually go through the clk tree.
>>> 2) The Tegra CCF rework series
>>>     -> This must go through the Tegra tree due to lots of dependencies
>>>     and merge conflicts with other Tegra patches.
>>> 3) This series
>>>     -> This would usually go through the clk tree.
>>>
>>> Is it possible to re-order the dependencies as (1) (3) (2), so that Mike
>>> can apply (1) and (3) to the clock tree, then I can use the clk tree as
>>> the basis for a branch in the Tegra tree to apply (2) and all the other
>>> Tegra patches that will conflict with (2)?
>>
>> If Mike approves the concept and implementation in (1) and (3) then I 
>> will repost (2) and (3) with dependencies re-ordered.
> 
> Patch (1) still has some unaddressed comments, and is not a real
> dependency for this series.

I assume "Patch (1)" refers to the list of series a couple emails above,
not the first patch in the series you're replying to; that threw me for
a moment.

> Since all of the patches have received their
> Tested-by's then I propose to merge all patches from this series into
> clk-next, which exception of patch 2/7 (the Tegra patch).
> 
> This reduces your Tegra CCF conversion dependencies and you can role the
> necessary of_clk_init change into your Tegra CCF conversion branch (it
> has my implicit Ack and can be taken through your tree).
> 
> Let me know if this is OK for you.

OK, I'm happy to merge your clock tree into the Tegra tree and then
apply 2/7 on top of the Tegra CCF work.
