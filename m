From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Jan 2013 15:16:34 -0700
Subject: [PATCH V5 1/3] clk: tegra: add Tegra specific clocks
In-Reply-To: <20130122212448.24671.89455@quantum>
References: <1358369575-7325-1-git-send-email-swarren@wwwdotorg.org>
 <20130122212448.24671.89455@quantum>
Message-ID: <50FF0FC2.6020908@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2013 02:24 PM, Mike Turquette wrote:
> Quoting Stephen Warren (2013-01-16 12:52:53)
>> From: Prashant Gaikwad <pgaikwad@nvidia.com>
>>
>> Add Tegra specific clocks, pll, pll_out, peripheral, frac_divider, super.
>>
>> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
>> [swarren: alloc sizeof(*foo) not sizeof(struct foo), add comments re:
>> storing pointers to stack variables, make a timeout loop more idiomatic,
>> use _clk_pll_disable() not clk_disable_pll() from _program_pll() to
>> avoid redundant lock operations, unified tegra_clk_periph() and
>> tegra_clk_periph_nodiv(), unified tegra_clk_pll{,e}, rename all clock
>> registration functions so they don't have the same name as the clock
>> structs.]
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> V5: Implemented all changes marked [swarren] in the commit descriptions.
>>
>> Mike, These patches depend on a couple patches in the Tegra tree, and
>> various other Tegra patches depend on them. I'd like to take these through
>> the Tegra tree. Can you please ack or otherwise OK this? Thanks.
>>
> 
> For the series, including the updated v6 patch 2/3:
> 
> Acked-by: Mike Turquette <mturquette@linaro.org>

Thanks very much for the review.

I'm working on applying these patches and the other related ARM-side
patches to the Tegra for-3.9/soc branch as we speak.
