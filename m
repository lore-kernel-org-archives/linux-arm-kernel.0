From: stigge@antcom.de (Roland Stigge)
Date: Fri, 26 Oct 2012 13:05:54 +0200
Subject: [PATCH 2/2] ARM: mach-imx: CAN clock fix for i.MX53
In-Reply-To: <508A665C.80107@pengutronix.de>
References: <1351164400-27940-1-git-send-email-stigge@antcom.de>
 <1351164400-27940-2-git-send-email-stigge@antcom.de>
 <20121026085934.GA1641@pengutronix.de> <508A54E4.2060108@antcom.de>
 <508A665C.80107@pengutronix.de>
Message-ID: <508A6E92.1000107@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2012 12:30 PM, Marc Kleine-Budde wrote:
>>>> +	clk[can1_serial_gate] = imx_clk_gate2("can1_serial_gate",
>>>> "can_sel", MXC_CCM_CCGR4, 6); +	clk[can1_ipg_gate] =
>>>> imx_clk_gate2("can1_ipg_gate", "ipg", MXC_CCM_CCGR4, 8); +
>>>> clk[can2_serial_gate] = imx_clk_gate2("can2_serial_gate",
>>>> "can_sel", MXC_CCM_CCGR4, 6); +	clk[can2_ipg_gate] =
>>>> imx_clk_gate2("can2_ipg_gate", "ipg", MXC_CCM_CCGR4, 8);
>>> 
>>> This doesn't.
>> 
>> This may be right, but unfortunately, since the introduction of
>> your can1 + can2 clocking change, the first block stopped working
>> for me.
> 
> You are effectively using can2's clock for can1. Are you sure you 
> haven't mixed up can1 and can2?

Just using the above patch and patch 1/2 from this series (missing can
pinmuxing), doing like this in custom .dts:

+                       can1: can at 53fc8000 {
+                               pinctrl-names = "default";
+                               pinctrl-0 = <&pinctrl_can1_1>;
+                               clock-frequency = <66500000>;
+                               status = "okay";
+                       };

Then, the can0 interface appears which can be upped as network interface.

Quite straightforward, isn't it?

Roland
