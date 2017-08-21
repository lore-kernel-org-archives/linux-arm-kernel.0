From: wulf@rock-chips.com (wlf)
Date: Mon, 21 Aug 2017 19:35:00 +0800
Subject: [PATCH v2 1/2] arm64: dts: rockchip: add usb3 controller node for
 RK3328 SoCs
In-Reply-To: <7917076.Ei9Henru6l@phil>
References: <1502956490-23087-1-git-send-email-william.wu@rock-chips.com>
 <1502956490-23087-2-git-send-email-william.wu@rock-chips.com>
 <7917076.Ei9Henru6l@phil>
Message-ID: <372dfa18-48a8-c104-03e8-b922304b8c02@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Heiko,

? 2017?08?18? 17:24, Heiko Stuebner ??:
> Hi William,
>
> Am Donnerstag, 17. August 2017, 15:54:49 CEST schrieb William Wu:
>> RK3328 has one USB 3.0 OTG controller which uses DWC_USB3
>> core's general architecture. It can act as static xHCI host
>> controller, static device controller, USB 3.0/2.0 OTG basing
>> on ID of USB3.0 PHY.
>>
>> Signed-off-by: William Wu <william.wu@rock-chips.com>
>> ---
>> Changes in v2:
>> - Modify the dwc3 quirk "snps,tx-ipgap-linecheck-dis-quirk" to
>>    "snps,dis-tx-ipgap-linecheck-quirk"
>>
>>   .../devicetree/bindings/usb/rockchip,dwc3.txt      |  4 +++-
>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 27 ++++++++++++++++++++++
>>   2 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
>> index 0536a93..d6b2e47 100644
>> --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
>> +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
>> @@ -1,7 +1,9 @@
>>   Rockchip SuperSpeed DWC3 USB SoC controller
>>   
>>   Required properties:
>> -- compatible:	should contain "rockchip,rk3399-dwc3" for rk3399 SoC
>> +- compatible:	should be one of the following:
>> +  - "rockchip,rk3399-dwc3": for rk3399 SoC
>> +  - "rockchip,rk3328-dwc3", "rockchip,rk3399-dwc3": for rk3328 SoC
>>   - clocks:	A list of phandle + clock-specifier pairs for the
>>   		clocks listed in clock-names
>>   - clock-names:	Should contain the following:
> This probably shouldn't be part of the patch adding the dts node, but
> instead should be a separate patch and should either go through some
> usb tree or at least get an Ack from usb maintainers (Felipe Balbi and/or
> Greg Kroah Hartman), so you should definitly include them into your
> recipient list.
Thanks for your  suggestion. I will submit two patches separately, and 
add usb maintainers in
the recipient list.
>
>
> Heiko
>
>
>
>

-- 
??? William.Wu
?????????????89????A?21??
No.21 Building, A District, No.89,software Boulevard Fuzhou,Fujian, PRC
??: 13685012275
??: 0591-83991906-8520
??:wulf at rock-chips.com
