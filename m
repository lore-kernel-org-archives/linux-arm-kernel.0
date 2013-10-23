From: gerg@uclinux.org (Greg Ungerer)
Date: Wed, 23 Oct 2013 15:40:55 +1000
Subject: [PATCH 7/8] ARM: dts: imx: add IMX50 SoC device tree bindings
In-Reply-To: <20131022123544.GB31304@pengutronix.de>
References: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
 <1382076260-6422-8-git-send-email-gerg@uclinux.org>
 <20131022123544.GB31304@pengutronix.de>
Message-ID: <52676167.3050000@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

n 22/10/13 22:35, Sascha Hauer wrote:
> On Fri, Oct 18, 2013 at 04:04:19PM +1000, gerg at uclinux.org wrote:
>> From: Greg Ungerer <gerg@uclinux.org>
>>
>> Create device tree bindings for the Freescale IMX50 SoC. This was based on
>> the IMX53 bindings with changes made as necessary.
>>
>> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
>> ---
>> +
>> +			iomuxc: iomuxc at 53fa8000 {
>> +				compatible = "fsl,imx50-iomuxc";
>> +				reg = <0x53fa8000 0x4000>;
>> +
>> +				fec {
>> +					pinctrl_fec_1: fecgrp-1 {
>> +						fsl,pins = <
>> +							MX50_PAD_SSI_RXFS__FEC_MDC	0x80
>> +							MX50_PAD_SSI_RXC__FEC_MDIO	0x80
>> +							MX50_PAD_DISP_D0__FEC_TX_CLK	0x80
>> +							MX50_PAD_DISP_D1__FEC_RX_ERR	0x80
>> +							MX50_PAD_DISP_D2__FEC_RX_DV	0x80
>> +							MX50_PAD_DISP_D3__FEC_RDATA_1	0x80
>> +							MX50_PAD_DISP_D4__FEC_RDATA_0	0x80
>> +							MX50_PAD_DISP_D5__FEC_TX_EN	0x80
>> +							MX50_PAD_DISP_D6__FEC_TDATA_1	0x80
>> +							MX50_PAD_DISP_D7__FEC_TDATA_0	0x80
>> +						>;
>> +					};
>> +
> 
> Shawn recently removed the pinctrl groups here and referenced to this
> node by doing
> 
> &iomuxc {
> 	fec {
> 		...
> 	};
> };

Ok, I'll move them in the same way then.


>> +				cspi {
>> +					pinctrl_cspi_1: cspigrp-1 {
>> +						fsl,pins = <
>> +							MX50_PAD_CSPI_SCLK__CSPI_SCLK	0
> 
> 0 is definitely wrong here. We have 0x80000000 for "Don't touch
> padctrl", but otherwise this should contain some real padctrl settings.

0 was the intended value here. Although I am happy to hear arguments that 
it is not the correct value.

0 in this case translates to:

   . Low driver strength
   . Open drain disabled
   . Pull/Keep disabled

If the norm is to leave what the boot loader set then I will change them
to 0x80000000. Is the net out of the discussion that followed to do this?

Thanks for looking over the patches.

Regards
Greg
