From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Sat, 02 Aug 2014 15:10:45 +0200
Subject: [PATCH v6 07/10] ARM: dts: Clean up exynos5250-arndale
In-Reply-To: <53DCE14A.3020108@gmail.com>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>
 <1406940750-15880-8-git-send-email-afaerber@suse.de>
 <53DCE14A.3020108@gmail.com>
Message-ID: <53DCE355.7010004@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.08.2014 15:02, schrieb Tomasz Figa:
> On 02.08.2014 02:52, Andreas F?rber wrote:
>> Use the new style of referencing inherited nodes, use symbolic names,
>> tidy indentation and reorder includes.
>>
>> Goal is the alignment of all exynos5250 based device trees for comparison.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  v5 -> v6:
>>  * Updated for mfc node label
>>  
>>  v5: New
>>  Aligns with SMDK.
>>
>>  arch/arm/boot/dts/exynos5250-arndale.dts | 929 ++++++++++++++++---------------
>>  1 file changed, 466 insertions(+), 463 deletions(-)
>>
> 
> Diff in resulting dtb:

Same here, appears to be over whole series:

>> --- exynos5250-arndale.dtb.dts	2014-08-02 14:54:15.102905920 +0200
>> +++ ../dtbs.post/exynos5250-arndale.dtb.dts	2014-08-02 14:54:15.104905920 +0200
>> @@ -1977,7 +1977,7 @@
>>  		clocks = <0x2 0x158 0x2 0x88 0x2 0x89 0x2 0x9f 0x2 0x400>;
>>  		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel", "sclk_hdmiphy", "mout_hdmi";
>>  		samsung,syscon-phandle = <0x7>;
>> -		hpd-gpio = <0xc 0x7 0x2>;
>> +		hpd-gpio = <0xc 0x7 0x1>;
>>  		vdd_osc-supply = <0x31>;
>>  		vdd_pll-supply = <0x32>;
>>  		vdd-supply = <0x32>;

Optional follow-up patch 08/10.

>> @@ -2104,15 +2104,9 @@
>>  		};
>>  	};
>>  
>> -	usb_hub_bus {
>> -		compatible = "simple-bus";
>> -		#address-cells = <0x1>;
>> -		#size-cells = <0x0>;
>> -
>> -		usb_hub {
>> -			compatible = "smsc,usb3503a";
>> -			reset-gpios = <0xc 0x5 0x1>;
>> -			connect-gpios = <0x10 0x7 0x1>;
>> -		};
>> +	usb-hub {
>> +		compatible = "smsc,usb3503a";
>> +		reset-gpios = <0xc 0x5 0x1>;
>> +		connect-gpios = <0x10 0x7 0x1>;
>>  	};
>>  };

Optional follow-up patch 09/10.

> Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Thanks,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
