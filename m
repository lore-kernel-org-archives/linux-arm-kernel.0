From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 28 Sep 2011 10:50:44 -0500
Subject: [PATCH v3 3/6] OMAP3+: use DPLL's round_rate when setting rate
In-Reply-To: <alpine.DEB.2.00.1109280059380.4399@utopia.booyaka.com>
References: <1316195281-14988-1-git-send-email-jon-hunter@ti.com>
	<alpine.DEB.2.00.1109280059380.4399@utopia.booyaka.com>
Message-ID: <4E834254.9040802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 9/28/2011 2:02, Paul Walmsley wrote:
> Hi,
>
> On Fri, 16 Sep 2011, Jon Hunter wrote:
>
>> From: Mike Turquette<mturquette@ti.com>
>>
>> omap3_noncore_dpll_set_rate uses omap2_dpll_round_rate explicitly.  Instead
>> use the struct clk pointer's round_rate function to allow for DPLL's with
>> special needs.
>>
>> Also the rounded rate can differ from target rate, so to better reflect
>> reality set clk->rate equal to the rounded rate when setting DPLL frequency.
>> This avoids issues where the DPLL frequency is slightly different than what
>> debugfs clock tree reports using the old target rate.
>>
>> An example of both of these needs is DPLL_ABE on OMAP4 which can have a 4x
>> multiplier on top of the usual MN dividers depending on register settings.
>> This requires a special round_rate function that might yield a rate
>> different from the initial target.
>>
>> Signed-off-by: Mike Turquette<mturquette@ti.com>
>> Signed-off-by: Jon Hunter<jon-hunter@ti.com>
>
> The two separate changes in this patch have been separated out into two
> patches - both included below.  Please let me know if you have any
> comments; otherwise, I'll queue for 3.2.

Yes, looks good to me. Thanks. Jon
