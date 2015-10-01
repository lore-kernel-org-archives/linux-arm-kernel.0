From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 1 Oct 2015 08:57:40 +0300
Subject: [PATCH 01/11 RESEND] ARM: OMAP: DRA7: hwmod: Add data for McASP3
In-Reply-To: <560BDCF8.20909@ti.com>
References: <1442326206-30192-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1509270631440.7947@utopia.booyaka.com>
 <560BB434.6080308@ti.com> <560BDCF8.20909@ti.com>
Message-ID: <560CCB54.60306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30/2015 04:00 PM, Tero Kristo wrote:
>>>> +/* l4_per2 -> mcasp3 */
>>>> +static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp3 = {
>>>> +    .master        = &dra7xx_l4_per2_hwmod,
>>>> +    .slave        = &dra7xx_mcasp3_hwmod,
>>>
>>> So this is the low-speed control/register access port, where the MPU
>>> writes to the McASP3 config registers...
>>>
>>>> +    .clk        = "l3_iclk_div",
>>>
>>> ... and thus this interface clock doesn't look right for this port, since
>>> it's most likely generated from the L4PER2, where this port is connected.
>>> So it should probably be "l4_iclk_div".
>>
>> There is no "l4_iclk_div" for dra7xx. Looking around the file all other script
>> generated data uses "l3_iclk_div" for IPs under dra7xx_l4_per2_hwmod.
>>
>> Tero: do you know the reason for this?
> 
> This comes from the autogen generated data. Looking at the hwdb data for dra7,
> it seems l3 clock is defined as the OCP input clock for most of the modules.
> 
> Looking at TRM, we also have L3 ICK defined as the interface clock for GPIO
> modules for example, and also mcasp modules.
> 
> I think this is just a documentation issue and we are missing a divide by 2
> from all interface clocks, the interface clocks are coming from l4
> interconnects and the interconnect chapter still clearly states that the l4
> clock is l3 clock / 2.

It seams that we have the clock node for the l4_iclk_div, but it is called as
l4_root_clk_div.

I will use this in the mcasp3 hwmod patch.

-- 
P?ter
