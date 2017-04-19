From: stefan@agner.ch (Stefan Agner)
Date: Wed, 19 Apr 2017 09:23:44 -0700
Subject: [PATCH v2 1/2] clk: imx7d: fix USDHC NAND clock
In-Reply-To: <20170419161435.GA7065@codeaurora.org>
References: <20170410210015.1620-1-stefan@agner.ch>
 <20170419161435.GA7065@codeaurora.org>
Message-ID: <9f0b9e83bc2a46bacb323d3ff2cfcf64@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-04-19 09:14, Stephen Boyd wrote:
> On 04/10, Stefan Agner wrote:
>> The USDHC NAND root clock is not gated by any CCM clock gate. Remove
>> the bogus gate definition.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
> 
> Can this be applied? It's followed by a dtsi change and there is
> zero information about if the two depend on each other. Please
> add cover letters for these sorts of things in the future
> indicating how you expect merging to work.

This can be merged. The two changes are independent.

They look kind of dependent, but really aren't since
IMX7D_NAND_USDHC_BUS_ROOT_CLK is still in the init_on list. Should have
explicitly mentioned that, sorry about that.

--
Stefan
