From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 20 May 2015 20:43:38 +0300
Subject: [PATCHv2 02/27] clk: ti: move generic OMAP DPLL implementation
 under drivers/clk
In-Reply-To: <20150520012053.GC31054@codeaurora.org>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
 <1431334493-24455-3-git-send-email-t-kristo@ti.com>
 <20150520012053.GC31054@codeaurora.org>
Message-ID: <555CC7CA.2090104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2015 04:20 AM, Stephen Boyd wrote:
> On 05/11, Tero Kristo wrote:
>> With the legacy clock data now gone, we can start moving OMAP clock
>> type implementations under clock driver. Start this with moving the
>> generic OMAP DPLL clock type under TI clock driver.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>
> How much of the code is the same from the original copy? Can you
> generate these patches with -M -C so that we can see?

Looks like for the move patches the range is from 85%...95% exact copy. 
Shall I repost the patches in this format? Good hint for the -M -C btw, 
I wonder why those are not default options for git-format-patch.

-Tero

>
>>   arch/arm/mach-omap2/Makefile    |    2 +-
>>   arch/arm/mach-omap2/clkt_dpll.c |  370 ---------------------------------------
>>   drivers/clk/ti/Makefile         |    3 +-
>>   drivers/clk/ti/clkt_dpll.c      |  369 ++++++++++++++++++++++++++++++++++++++
>>   drivers/clk/ti/clock.h          |    2 +
>>   include/linux/clk/ti.h          |    1 -
>>   6 files changed, 374 insertions(+), 373 deletions(-)
>>   delete mode 100644 arch/arm/mach-omap2/clkt_dpll.c
>>   create mode 100644 drivers/clk/ti/clkt_dpll.c
>
