From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 28 Sep 2011 10:37:39 -0500
Subject: [PATCH v2 2/6] OMAP4: Clock: round_rate and recalc functions
	for DPLL_ABE
In-Reply-To: <alpine.DEB.2.00.1109280056570.4399@utopia.booyaka.com>
References: <1316195263-14951-1-git-send-email-jon-hunter@ti.com>
	<alpine.DEB.2.00.1109280056570.4399@utopia.booyaka.com>
Message-ID: <4E833F43.9000406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 9/28/2011 1:59, Paul Walmsley wrote:
> Hi Jon and Mike,
>
> On Fri, 16 Sep 2011, Jon Hunter wrote:
>
>> From: Mike Turquette<mturquette@ti.com>
>>
>> OMAP4 DPLL_ABE can enable a 4X multipler on top of the normal MN multipler
>> and divider. This is achieved by setting CM_CLKMODE_DPLL_ABE.DPLL_REGM4XEN
>> bit in CKGEN module of CM1. From the OMAP4 TRM:
>>
>> Fdpll = Fref x 2 x (4 x M/(N+1)) in case REGM4XEN bit field is set (only
>> applicable to DPLL_ABE).
>>
>> Add new round_rate() and recalc() functions for OMAP4, that check the
>> setting of REGM4XEN bit and handle this appropriately. The new functions
>> are a simple wrapper on top of the existing omap2_dpll_round_rate() and
>> omap2_dpll_get_rate() functions to handle the REGM4XEN bit.
>>
>> The REGM4XEN bit is only implemented for the ABE DPLL on OMAP4 and so
>> only dpll_abe_ck uses omap4_dpll_regm4xen_round_rate() and
>> omap4_dpll_regm4xen_recalc() functions.
>>
>> Signed-off-by: Mike Turquette<mturquette@ti.com>
>> Tested-by: Jon Hunter<jon-hunter@ti.com>
>
> Some changes have been made to this patch here, to fix a few minor bugs in
> error paths and to add documentation and Jon's Signed-off-by: (since he's
> in the submittal chain).
>
> Care to review and send any comments?  Otherwise, I plan to queue this
> revised version for 3.2.

Looks good to me. Thanks for fixes and documentation.

Cheers
Jon
