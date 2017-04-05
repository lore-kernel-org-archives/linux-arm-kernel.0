From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Wed, 05 Apr 2017 10:07:41 +0800
Subject: [PATCH v4 4/6] arm64: dts: rockchip: add core dtsi file for RK3328
 SoCs
In-Reply-To: <6636047.jL6XHNkknt@phil>
References: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
 <1490607650-18650-4-git-send-email-cl@rock-chips.com>
 <6636047.jL6XHNkknt@phil>
Message-ID: <58E4516D.4000805@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/05/2017 12:04 AM, Heiko Stuebner wrote:
> Am Montag, 27. M?rz 2017, 17:40:48 CEST schrieb cl at rock-chips.com:
>> From: Liang Chen <cl@rock-chips.com>
>>
>> This patch adds core dtsi file for Rockchip RK3328 SoCs.
>>
>> Signed-off-by: Liang Chen <cl@rock-chips.com>
>
> applied for 4.12, with the following list of changes:
>
> - reorder some properties to bring them in alphabetical order
> - dropped the status-disabled from the power-controller
>    power-domain control is a quite essential part of the system, so if
>    boards really want to disable them, they should do it in their board file
>    Having power-domains on all the time, is also our default in all other
>    devicetrees.
> - removed #dma-cells from spi0 -> this is not a dma controller
> - reword the cru assigned-clocks comment a bit
> - fixed sdmmc1_bus4 pins, as indicated by Shawn and after looking up the
>    correct pins in the manual
>
>
> And a final question, are you sure about SCLK_PDM becoming a child of the
> APLL in your cru assigned-clocks, as the APLL will vary later on with cpufreq
> active?
>
the NPLL will vary later on with cpufreq active.

The NPLL is better than APLL, so NPLL is for clk_core,and apll is for pdm.

please see the TRM in CRU:
1.4 Function Description
/........./
To maximize the flexibility, some of clocks can select divider source 
from 5 PLLs. (Note: It?s
recommended to use NEW PLL instead of ARM PLL as arm clock source, 
because NEW PLL is
near to ARM. And it?s jitter is better than ARM PLL).

>
> Heiko
>
>
>
