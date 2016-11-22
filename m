From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 22 Nov 2016 10:41:24 +0100
Subject: [PATCH 1/2] ARM64: dts: Add support for Meson GXM
In-Reply-To: <m2oa181jtd.fsf@baylibre.com>
References: <20161121162905.14285-1-narmstrong@baylibre.com>
 <20161121162905.14285-2-narmstrong@baylibre.com>
 <m2oa181jtd.fsf@baylibre.com>
Message-ID: <65b791bb-243e-ded9-e651-4021f0b23f1a@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2016 12:42 AM, Kevin Hilman wrote:
> Neil,
> 
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
>> Following the Amlogic Linux kernel, it seem the only differences
>> between the GXL and GXM SoCs are the CPU Clusters.
>>
>> This commit renames the gxl-s905d-p23x DTSI in a common file for
>> S905D p20x and S912 q20x boards.
> 
> s/p20x/p23x/ ??
> 
>> Then adds a meson-gxm dtsi and reproduce the P23x to Q20x boards
>> dts files since the S905D and S912 SoCs shares the same pinout
>> and the P23x and Q20x boards are identical.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> I had to drop this as it breaks the network on (at least) gxbb-p200, but...
> 
> [...]
> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
>> index 03e3d76..17bb77c 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
>> @@ -56,3 +56,22 @@
>>  	pinctrl-0 = <&i2c_b_pins>;
>>  	pinctrl-names = "default";
>>  };
>> +
>> +&ethmac {
>> +	status = "okay";
>> +	pinctrl-0 = <&eth_rgmii_pins>;
>> +	pinctrl-names = "default";
>> +
>> +	phy-handle = <&eth_phy0>;
>> +
>> +	mdio {
>> +		compatible = "snps,dwmac-mdio";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		eth_phy0: ethernet-phy at 0 {
>> +			reg = <0>;
>> +			realtek,disable-eee-1000t;
>> +		};
>> +	};
>> +};
> 
> ... backing out this change makes it work again.
> 
> This change also looks suspicious as it's using the proposed disable-eee
> properties, which I don't think have been merged yet.
> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
>> index 39bb037..5608c51 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
>> @@ -50,3 +50,10 @@
>>  	compatible = "amlogic,p201", "amlogic,meson-gxbb";
>>  	model = "Amlogic Meson GXBB P201 Development Board";
>>  };
>> +
>> +&ethmac {
>> +	status = "okay";
>> +	pinctrl-0 = <&eth_rmii_pins>;
>> +	pinctrl-names = "default";
>> +	phy-mode = "rmii";
>> +};
> 
> This also doesn't look releveant to the GXL/GXM changes being introduced
> in this patch.
> 
> Could you separate out any GXBB-related changes into a separate patch
> (if they are in fact needed) and re-spin this?
> 
> Thanks,
> 
> Kevin
> 

Sorry leftover for another work...

Will cleanup for v2.

Neil
