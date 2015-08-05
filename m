From: rogerq@ti.com (Roger Quadros)
Date: Wed, 5 Aug 2015 11:08:38 +0300
Subject: [PATCH 10/10] ARM: dts: omap4: Use "syscon-otghs" instead of
 "ctrl-module" in USB node
In-Reply-To: <55C1C325.5040703@ti.com>
References: <1438702233-8027-1-git-send-email-kishon@ti.com>
 <1438702233-8027-11-git-send-email-kishon@ti.com> <55C1C325.5040703@ti.com>
Message-ID: <55C1C486.6050202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/15 11:02, Roger Quadros wrote:
> Kishon,
> 
> On 04/08/15 18:30, Kishon Vijay Abraham I wrote:
>> Add "syscon-otghs" property and remove the deprecated "ctrl-module"
>> property from MUSB devicetree node.
>>
>> Since "omap_control_usbotg" devicetree node is no longer used, remove
>> it.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  arch/arm/boot/dts/omap4.dtsi |    8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index b27634d..2fb49a5 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -854,12 +854,6 @@
>>  			};
>>  		};
>>  
>> -		omap_control_usbotg: control-phy at 4a00233c {
>> -			compatible = "ti,control-phy-otghs";
>> -			reg = <0x4a00233c 0x4>;
>> -			reg-names = "otghs_control";
>> -		};
>> -
>>  		usb_otg_hs: usb_otg_hs at 4a0ab000 {
>>  			compatible = "ti,omap4-musb";
>>  			reg = <0x4a0ab000 0x7ff>;
>> @@ -872,7 +866,7 @@
>>  			multipoint = <1>;
>>  			num-eps = <16>;
>>  			ram-bits = <12>;
>> -			ctrl-module = <&omap_control_usbotg>;
>> +			syscon-otghs = <&scm_conf 0x33c>;
> 
> All other properties were of the format "syscon-phy-foo".
> Why use a different format here?
> 

Ah, looks like we don't have a dedicated phy driver for this?
We will need to add a PHY driver I guess then and handle this register
in that driver rather than in the musb driver.

cheers,
-roger
> 
> 
>>  		};
>>  
>>  		aes: aes at 4b501000 {
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
