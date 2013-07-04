From: b32955@freescale.com (Huang Shijie)
Date: Thu, 4 Jul 2013 16:42:39 +0800
Subject: [PATCH v2 4/5] ARM: dts: imx6q: add dte pinctrl for uart2
In-Reply-To: <20130704072344.GB11046@S2101-09.ap.freescale.net>
References: <1372844557-3078-1-git-send-email-b32955@freescale.com>
 <1372844557-3078-5-git-send-email-b32955@freescale.com>
 <20130704072344.GB11046@S2101-09.ap.freescale.net>
Message-ID: <51D5357F.8040609@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?04? 15:23, Shawn Guo ??:
> On Wed, Jul 03, 2013 at 05:42:36PM +0800, Huang Shijie wrote:
>> In imx6q-arm2 board, the UART2 works in the dte mode.
>> So add a pinctrl for it.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> ---
>>   arch/arm/boot/dts/imx6q.dtsi |    9 +++++++++
>>   1 files changed, 9 insertions(+), 0 deletions(-)
> Since imx6q and imx6dl are pin-to-pin compatible, from now on I would
> require the same pin group be added for these two SoC together, so that
> we can enforce the same label name.
>
I knew it.

But this pinctrl is only used in imx6q-arm2 board which uses a big 
armdillo board,
so i did not add the same label to imx6dl.

Do we have a imx6dl-arm2 board? if we have , i can add it.


>> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
>> index 9a69891..8a518c6 100644
>> --- a/arch/arm/boot/dts/imx6q.dtsi
>> +++ b/arch/arm/boot/dts/imx6q.dtsi
>> @@ -266,6 +266,15 @@
>>   							MX6Q_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
>>   						>;
>>   					};
>> +
>> +					pinctrl_uart2_dte: uart2grp-2 {
>> +						fsl,pins =<
>> +							MX6Q_PAD_EIM_D26__UART2_RX_DATA 0x1b0b1
>> +							MX6Q_PAD_EIM_D27__UART2_TX_DATA 0x1b0b1
>> +							MX6Q_PAD_EIM_D28__UART2_CTS_B	0x1b0b1
>> +							MX6Q_PAD_EIM_D29__UART2_CTS_B	0x1b0b1
> Why do you have two pads mux-ed on one function?
I think the name of the PAD is wrong.

thanks
Huang Shijie
