From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 11 Oct 2012 16:05:10 +0530
Subject: [PATCH 01/13] clk: davinci - add Main PLL clock driver
In-Reply-To: <507563C3.2000305@ti.com>
References: <1348682889-9509-1-git-send-email-m-karicheri2@ti.com>
 <1348682889-9509-2-git-send-email-m-karicheri2@ti.com>
 <507563C3.2000305@ti.com>
Message-ID: <5076A0DE.4070900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2012 5:32 PM, Sekhar Nori wrote:
> Hi Murali,
> 
> On 9/26/2012 11:37 PM, Murali Karicheri wrote:
>> This is the driver for the main PLL clock hardware found on DM SoCs.
>> This driver borrowed code from arch/arm/mach-davinci/clock.c and
>> implemented the driver as per common clock provider API. The main PLL
>> hardware typically has a multiplier, a pre-divider and a post-divider.
>> Some of the SoCs has the divider fixed meaning they can not be
>> configured through a register. HAS_PREDIV and HAS_POSTDIV flags are used
>> to tell the driver if a hardware has these dividers present or not.
>> Driver is configured through the structure clk_davinci_pll_data
>> that has the platform data for the driver.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> 
> Are you using git-format-patch to generate the patches? It should have
> added a diffstat here by default which is very useful in quickly
> understanding what the patch is touching.
>>
>> diff --git a/drivers/clk/davinci/clk-davinci-pll.c b/drivers/clk/davinci/clk-davinci-pll.c

Looking at how common clock framework for mxs has been implemented, this
file should simply be clk-pll.c. That makes sense as you are creating a
davinci folder anyway. Similar change required for psc as well.

Thanks,
Sekhar
