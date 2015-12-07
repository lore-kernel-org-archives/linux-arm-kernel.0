From: jenskuske@gmail.com (Jens Kuske)
Date: Mon, 7 Dec 2015 19:44:30 +0100
Subject: [PATCH v5 3/4] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <20151207091257.070723b67db726d9f05c6550@free.fr>
References: <1449264283-25360-1-git-send-email-jenskuske@gmail.com>
 <1449264283-25360-4-git-send-email-jenskuske@gmail.com>
 <20151207091257.070723b67db726d9f05c6550@free.fr>
Message-ID: <5665D38E.4050406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/15 09:12, Jean-Francois Moine wrote:
> On Fri,  4 Dec 2015 22:24:42 +0100
> Jens Kuske <jenskuske@gmail.com> wrote:
> 
>> The Allwinner H3 is a home entertainment system oriented SoC with
>> four Cortex-A7 cores and a Mali-400MP2 GPU.
>>
>> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
>> ---
>>  arch/arm/boot/dts/sun8i-h3.dtsi | 497 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 497 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sun8i-h3.dtsi
>>
>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
>> new file mode 100644
>> index 0000000..1524130e
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>> @@ -0,0 +1,497 @@
> 	[snip]
>> +		bus_gates: clk at 01c20060 {
>> +			#clock-cells = <1>;
>> +			compatible = "allwinner,sun8i-h3-bus-gates-clk";
>> +			reg = <0x01c20060 0x14>;
>> +			clocks = <&ahb1>, <&ahb2>, <&apb1>, <&apb2>;
>> +			clock-names = "ahb1", "ahb2", "apb1", "apb2";
>> +			clock-indices = <5>, <6>, <8>,
>> +					<9>, <10>, <13>,
>> +					<14>, <17>, <18>,
>> +					<19>, <20>,
>> +					<21>, <23>,
>> +					<24>, <25>,
>> +					<26>, <27>,
>> +					<28>, <29>,
>> +					<30>, <31>, <32>,
>> +					<35>, <36>, <37>,
>> +					<40>, <41>, <43>,
>> +					<44>, <52>, <53>,
>> +					<54>, <64>,
>> +					<65>, <69>, <72>,
>> +					<76>, <77>, <78>,
>> +					<96>, <97>, <98>,
>> +					<112>, <113>,
>> +					<114>, <115>,
>> +					<116>, <128>, <135>;
>> +			clock-output-names = "bus_ce", "bus_dma", "bus_mmc0",
>> +					     "bus_mmc1", "bus_mmc2", "bus_nand",
>> +					     "bus_sdram", "bus_gmac", "bus_ts",
>> +					     "bus_hstimer", "bus_spi0",
>> +					     "bus_spi1", "bus_otg",
>> +					     "bus_otg_ehci0", "bus_ehci1",
>> +					     "bus_ehci2", "bus_ehci3",
>> +					     "bus_otg_ohci0", "bus_ohci1",
>> +					     "bus_ohci2", "bus_ohci3", "bus_ve",
>> +					     "bus_lcd0", "bus_lcd1", "bus_deint",
> 
> The tcon1 clock is used by both lcd0 and lcd1, while the tcon0 clock is used for TV output from lcd1, so, this should be:
> 
> 	"bus_tcon0", "bus_tcon1", "bus_deint",
> 
> (the tcon1 clock is used by both lcd0 and lcd1, while
>  the tcon0 clock is used for TV output from lcd1)

Hi,

These are only the ahb bus gates, not the module clocks.
Naming them lcd might be a bit confusing, but it follows the naming we
used since sun4i. And the tcon modules are still called lcd0 and lcd1
module in the manual too.

Interestingly there is only a tcon0 module clock in the manual and no
tcon1, but that is not part of this patch.

Jens


> 
>> +					     "bus_csi", "bus_tve", "bus_hdmi",
>> +					     "bus_de", "bus_gpu", "bus_msgbox",
>> +					     "bus_spinlock", "bus_codec",
>> +					     "bus_spdif", "bus_pio", "bus_ths",
>> +					     "bus_i2s0", "bus_i2s1", "bus_i2s2",
>> +					     "bus_i2c0", "bus_i2c1", "bus_i2c2",
>> +					     "bus_uart0", "bus_uart1",
>> +					     "bus_uart2", "bus_uart3",
>> +					     "bus_scr", "bus_ephy", "bus_dbg";
>> +		};
> 	[snip]
> 
