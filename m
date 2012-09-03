From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 03 Sep 2012 17:22:52 +0200
Subject: [PATCHv2 2/3] ARM: dts: mxs Add additionnal muxing options for
 SSP3
In-Reply-To: <20120903145343.GI2362@S2101-09.ap.freescale.net>
References: <1346666749-6094-1-git-send-email-maxime.ripard@free-electrons.com>
 <1346666749-6094-2-git-send-email-maxime.ripard@free-electrons.com>
 <20120903145343.GI2362@S2101-09.ap.freescale.net>
Message-ID: <5044CB4C.7080302@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/09/2012 16:53, Shawn Guo a ?crit :
> On Mon, Sep 03, 2012 at 12:05:48PM +0200, Maxime Ripard wrote:
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/imx28.dtsi |   11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
>> index 8497a0e..6c51ff4 100644
>> --- a/arch/arm/boot/dts/imx28.dtsi
>> +++ b/arch/arm/boot/dts/imx28.dtsi
>> @@ -586,6 +586,17 @@
>>  					fsl,voltage = <1>;
>>  					fsl,pull-up = <1>;
>>  				};
>> +
>> +				spi3_pins_b: spi3 at 1 {
>> +					reg = <1>;
>> +					fsl,pinmux-ids = <
>> +						0x0181 /* MX28_PAD_GPMI_RDN__SSP3_SCK */
>> +						0x01c1 /* MX28_PAD_GPMI_RESETN__SSP3_CMD */
> 
> The spi only needs two pins to work?

Oops. I only used MOSI, so I forgot to mux MISO.
Sorry about that, this will be fixed in the new version.

> Has spi3_pins_a been defined?  I haven't seen it.

It's the same thing as the first patch. I had Marek's last patch in my
tree that adds spi3_pins_a. I will change it in the next version.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
