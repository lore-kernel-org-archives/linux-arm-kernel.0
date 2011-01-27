From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 27 Jan 2011 09:48:50 -0200
Subject: [PATCH 1/3] ARM: mach-mx5: Fix build for mx53_loco and mx53_smd
In-Reply-To: <20110127093044.GA30756@shlinux1.ap.freescale.net>
References: <1295968115-11447-1-git-send-email-fabio.estevam@freescale.com>
	<20110127073009.GR9041@pengutronix.de>
	<20110127093044.GA30756@shlinux1.ap.freescale.net>
Message-ID: <4D415BA2.2020207@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On 1/27/2011 7:30 AM, Richard Zhao wrote:
....
>>>  static iomux_v3_cfg_t mx53_loco_pads[] = {
>>> -	MX53_PAD_CSI0_D10__UART1_TXD,
>>> -	MX53_PAD_CSI0_D11__UART1_RXD,
>>> -	MX53_PAD_ATA_DIOW__UART1_TXD,
>>> -	MX53_PAD_ATA_DMACK__UART1_RXD,
>>> -
>>> -	MX53_PAD_ATA_BUFFER_EN__UART2_RXD,
>>> -	MX53_PAD_ATA_DMARQ__UART2_TXD,
>>> -	MX53_PAD_ATA_DIOR__UART2_RTS,
>>> -	MX53_PAD_ATA_INTRQ__UART2_CTS,
>>> -
>>> -	MX53_PAD_ATA_CS_0__UART3_TXD,
>>> -	MX53_PAD_ATA_CS_1__UART3_RXD,
>>> -	MX53_PAD_ATA_DA_1__UART3_CTS,
>>> -	MX53_PAD_ATA_DA_2__UART3_RTS,
>>> +	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
>>> +	MX53_PAD_CSI0_DAT11__UART1_RXD_MUX,
>>> +	MX53_PAD_PATA_DIOW__UART1_TXD_MUX,
>>> +	MX53_PAD_PATA_DMACK__UART1_RXD_MUX,
> So many Pad configured to uart1?

As per the subject the intention of this patch is to fix the build for mx53_loco and mx53_smd.

In this patch I just changed the pad names to fix the build issue. 


>>> +
>>> +	MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX,
>>> +	MX53_PAD_PATA_DMARQ__UART2_TXD_MUX,
>>> +	MX53_PAD_PATA_DIOR__UART2_RTS,
>>> +	MX53_PAD_PATA_INTRQ__UART2_CTS,
>>> +
>>> +	MX53_PAD_PATA_CS_0__UART3_TXD_MUX,
>>> +	MX53_PAD_PATA_CS_1__UART3_RXD_MUX,
>>> +	MX53_PAD_PATA_DA_1__UART3_CTS,
>>> +	MX53_PAD_PATA_DA_2__UART3_RTS,
> LoCo don't have uart2 and uart3.

Right, these are removed later in my patch series.

After my patch series is applied we have a working UART1 console.

Can we apply them? 

Regards,

Fabio Estevam
>>> +
>>>  };
>>>  
>>>  static const struct imxuart_platform_data mx53_loco_uart_data __initconst = {
>>> diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
>>> index 7970f7a..06070c5 100644
>>> --- a/arch/arm/mach-mx5/board-mx53_smd.c
>>> +++ b/arch/arm/mach-mx5/board-mx53_smd.c
>>> @@ -39,20 +39,20 @@
>>>  #define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
>>>  
>>>  static iomux_v3_cfg_t mx53_smd_pads[] = {
>>> -	MX53_PAD_CSI0_D10__UART1_TXD,
>>> -	MX53_PAD_CSI0_D11__UART1_RXD,
>>> -	MX53_PAD_ATA_DIOW__UART1_TXD,
>>> -	MX53_PAD_ATA_DMACK__UART1_RXD,
>>> -
>>> -	MX53_PAD_ATA_BUFFER_EN__UART2_RXD,
>>> -	MX53_PAD_ATA_DMARQ__UART2_TXD,
>>> -	MX53_PAD_ATA_DIOR__UART2_RTS,
>>> -	MX53_PAD_ATA_INTRQ__UART2_CTS,
>>> -
>>> -	MX53_PAD_ATA_CS_0__UART3_TXD,
>>> -	MX53_PAD_ATA_CS_1__UART3_RXD,
>>> -	MX53_PAD_ATA_DA_1__UART3_CTS,
>>> -	MX53_PAD_ATA_DA_2__UART3_RTS,
>>> +	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
>>> +	MX53_PAD_CSI0_DAT11__UART1_RXD_MUX,
>>> +	MX53_PAD_PATA_DIOW__UART1_TXD_MUX,
>>> +	MX53_PAD_PATA_DMACK__UART1_RXD_MUX,
> same as above.
> 
> Thanks
> Richard
>>> +
>>> +	MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX,
>>> +	MX53_PAD_PATA_DMARQ__UART2_TXD_MUX,
>>> +	MX53_PAD_PATA_DIOR__UART2_RTS,
>>> +	MX53_PAD_PATA_INTRQ__UART2_CTS,
>>> +
>>> +	MX53_PAD_PATA_CS_0__UART3_TXD_MUX,
>>> +	MX53_PAD_PATA_CS_1__UART3_RXD_MUX,
>>> +	MX53_PAD_PATA_DA_1__UART3_CTS,
>>> +	MX53_PAD_PATA_DA_2__UART3_RTS,
>>>  };
>>>  
>>>  static const struct imxuart_platform_data mx53_smd_uart_data __initconst = {
>>> -- 
>>> 1.6.0.4
>>>
>>>
>>>
>>
>> -- 
>> Pengutronix e.K.                           |                             |
>> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
