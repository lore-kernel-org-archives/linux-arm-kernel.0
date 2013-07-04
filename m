From: b32955@freescale.com (Huang Shijie)
Date: Thu, 4 Jul 2013 17:06:37 +0800
Subject: [PATCH v2 4/5] ARM: dts: imx6q: add dte pinctrl for uart2
In-Reply-To: <20130704085623.GA11209@S2101-09.ap.freescale.net>
References: <1372844557-3078-1-git-send-email-b32955@freescale.com>
 <1372844557-3078-5-git-send-email-b32955@freescale.com>
 <20130704072344.GB11046@S2101-09.ap.freescale.net>
 <51D5357F.8040609@freescale.com>
 <20130704085623.GA11209@S2101-09.ap.freescale.net>
Message-ID: <51D53B1D.6000404@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?04? 16:56, Shawn Guo ??:
> On Thu, Jul 04, 2013 at 04:42:39PM +0800, Huang Shijie wrote:
>> But this pinctrl is only used in imx6q-arm2 board which uses a big
>> armdillo board,
>> so i did not add the same label to imx6dl.
>>
>> Do we have a imx6dl-arm2 board? if we have , i can add it.
> It does not matter whether or not the pin group is used on an imx6dl
> board.  We have to add it for both SoCs, because it's the only way to
> keep use same label for same pin group on two SoCs.
>
>>>> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
>>>> index 9a69891..8a518c6 100644
>>>> --- a/arch/arm/boot/dts/imx6q.dtsi
>>>> +++ b/arch/arm/boot/dts/imx6q.dtsi
>>>> @@ -266,6 +266,15 @@
>>>>   							MX6Q_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
>>>>   						>;
>>>>   					};
>>>> +
>>>> +					pinctrl_uart2_dte: uart2grp-2 {
> Forgot mentioning that in imx dts we generally do not encode function
> name like "dte" in the label but just number.
>
>>>> +						fsl,pins =<
>>>> +							MX6Q_PAD_EIM_D26__UART2_RX_DATA 0x1b0b1
>>>> +							MX6Q_PAD_EIM_D27__UART2_TX_DATA 0x1b0b1
>>>> +							MX6Q_PAD_EIM_D28__UART2_CTS_B	0x1b0b1
>>>> +							MX6Q_PAD_EIM_D29__UART2_CTS_B	0x1b0b1
>>> Why do you have two pads mux-ed on one function?
>> I think the name of the PAD is wrong.
> Fix the name first, then.
ok.

i will fix them in the next version.


thanks
Huang Shijie
