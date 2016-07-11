From: frank.wang@rock-chips.com (Frank Wang)
Date: Mon, 11 Jul 2016 15:43:03 +0800
Subject: [PATCH] arm64: dts: rockchip: support the usb2phy for rk3399 evb
In-Reply-To: <2150255.RfISFviJKP@phil>
References: <1467866800-24794-1-git-send-email-wxt@rock-chips.com>
 <2150255.RfISFviJKP@phil>
Message-ID: <cd9056c1-6fff-d02c-3fc0-3d48d9850504@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 2016/7/7 18:11, Heiko Stuebner wrote:
> Hi,
>
> Am Donnerstag, 7. Juli 2016, 12:46:40 schrieb Caesar Wang:
>> From: Frank Wang <frank.wang@rock-chips.com>
>>
>> This patch adds the usb2phy needed dts node information for rk3399.
>>
>> USB2.0 PHY is comprised of one Host port and one OTG port.
>> Host Port is for USB2.0 host controller; OTG port is for USB2.0 part of
>> USB3.0 OTG controller, and as a part to construct a fully feature TypeC
>> subsystem.
>>
>> The USB2.0 vbus gpio is board specific, it's no same with all rk3399
>> boards, so move it into evb voard.
>>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> ---
>>
>>   arch/arm64/boot/dts/rockchip/rk3399-evb.dts |  4 ++++
>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi    | 19 +++++++++++++++++++
>>   2 files changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index 4c84229..21d147f 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -242,6 +242,25 @@
>>   		status = "disabled";
>>   	};
>>
>> +	usb2phy: usb2phy {
>> +		compatible = "rockchip,rk3399-usb-phy";
>> +		rockchip,grf = <&grf>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		usb2phy0: usb2-phy0 {
>> +			#phy-cells = <0>;
>> +			#clock-cells = <0>;
>> +			reg = <0xe458>;
>> +		};
>> +
>> +		usb2phy1: usb2-phy1 {
>> +			#phy-cells = <0>;
>> +			#clock-cells = <0>;
>> +			reg = <0xe468>;
>> +		};
>> +	};
>> +
> The rk3399 uses the innosilicon usb2 phy and the binding we've come up for
> it looks a lot different than the above. So I'm not sure where this is
> coming from, especially as I haven't seen the driver part for the rk3399 at
> all yet. So far Frank was always working on te rk3366 variant, which seemed
> to be the most complete.

Yeah, rk3399 is ready for using the new driver and the binding which I 
have handed out earlier, but it seems that they have not applied yet, so 
shall we send out the new patches for rk3399 until they will be applied?

BR.
Frank

> Heiko
>
