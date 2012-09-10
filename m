From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Sep 2012 11:27:48 +0200
Subject: [PATCH 7/7] ARM: dts: cfa10049: Add the 74HC595 gpio expanders
In-Reply-To: <20120910022342.GR26709@S2101-09.ap.freescale.net>
References: <1347020296-18796-1-git-send-email-maxime.ripard@free-electrons.com>
 <1347020296-18796-8-git-send-email-maxime.ripard@free-electrons.com>
 <20120910022342.GR26709@S2101-09.ap.freescale.net>
Message-ID: <504DB294.7050309@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Le 10/09/2012 04:23, Shawn Guo a ?crit :
> On Fri, Sep 07, 2012 at 02:18:16PM +0200, Maxime Ripard wrote:
>> ---
>>  arch/arm/boot/dts/imx28-cfa10049.dts |   21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
>> index 1f7fa50..05c892e 100644
>> --- a/arch/arm/boot/dts/imx28-cfa10049.dts
>> +++ b/arch/arm/boot/dts/imx28-cfa10049.dts
>> @@ -27,6 +27,8 @@
>>  					fsl,pinmux-ids = <
>>  						0x0181 /* MX28_PAD_GPMI_RDN__SSP3_SCK */
>>  						0x01c1 /* MX28_PAD_GPMI_RESETN__SSP3_CMD */
>> +						0x0111 /* MX28_PAD_GPMI_CE1N__SSP3_D3 */
>> +						0x01a2 /* MX28_PAD_GPMI_ALE__SSP3_D4 */
> 
> What are these two pins used for?

The SSP_D3, D4 and D5 are used as chip select 0, 1 and 2 by the SSP
controller when it runs in the two SPI (motorola and Winbond) modes.
Thus, here, I'm using them as chip selects.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
