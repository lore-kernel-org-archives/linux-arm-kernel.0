From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Thu, 11 Oct 2012 14:10:16 +0000
Subject: [PATCH 01/13] clk: davinci - add Main PLL clock driver
In-Reply-To: <5076A0DE.4070900@ti.com>
References: <1348682889-9509-1-git-send-email-m-karicheri2@ti.com>
 <1348682889-9509-2-git-send-email-m-karicheri2@ti.com>
 <507563C3.2000305@ti.com> <5076A0DE.4070900@ti.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B7041FDA2E@DFLE12.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> -----Original Message-----
>> From: Nori, Sekhar
>> Sent: Thursday, October 11, 2012 6:35 AM
>> To: Nori, Sekhar
>> Cc: Karicheri, Muralidharan; Hilman, Kevin; davinci-linux-open-
>> source at linux.davincidsp.com; mturquette at linaro.org; linux-c6x-dev at linux-c6x.org;
>> arnd at arndb.de; linus.walleij at linaro.org; linux-kernel at vger.kernel.org;
>> rob.herring at calxeda.com; linux-keystone at list.ti.com - Linux developers for Keystone
>> family of devices (May contain non-TIers); viresh.linux at gmail.com;
>> linux at arm.linux.org.uk; akpm at linux-foundation.org; shawn.guo at linaro.org; linux-arm-
>> kernel at lists.infradead.org
>> Subject: Re: [PATCH 01/13] clk: davinci - add Main PLL clock driver
>> 
>> On 10/10/2012 5:32 PM, Sekhar Nori wrote:
>> > Hi Murali,
>> >
>> > On 9/26/2012 11:37 PM, Murali Karicheri wrote:
>> >> This is the driver for the main PLL clock hardware found on DM SoCs.
>> >> This driver borrowed code from arch/arm/mach-davinci/clock.c and
>> >> implemented the driver as per common clock provider API. The main PLL
>> >> hardware typically has a multiplier, a pre-divider and a post-divider.
>> >> Some of the SoCs has the divider fixed meaning they can not be
>> >> configured through a register. HAS_PREDIV and HAS_POSTDIV flags are
>> >> used to tell the driver if a hardware has these dividers present or not.
>> >> Driver is configured through the structure clk_davinci_pll_data that
>> >> has the platform data for the driver.
>> >>
>> >> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> >
>> > Are you using git-format-patch to generate the patches? It should have
>> > added a diffstat here by default which is very useful in quickly
>> > understanding what the patch is touching.
>> >>
>> >> diff --git a/drivers/clk/davinci/clk-davinci-pll.c
>> >> b/drivers/clk/davinci/clk-davinci-pll.c
>> 
>> Looking at how common clock framework for mxs has been implemented, this file should
>> simply be clk-pll.c. That makes sense as you are creating a davinci folder anyway. Similar
>> change required for psc as well.
>> 

Alternately, do we need  a davinci folder? Can't we just add it to the clk/ directory? These IPs are re-used in c6x and keystone architectures. So it make sense to keep in the clk folder. If agree, I can make this change in v3.

>> Thanks,
>> Sekhar
