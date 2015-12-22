From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 22 Dec 2015 16:07:51 +0200
Subject: [PATCH v2 1/2] ARM: dts: imx7d: cl-som-imx7: add basic module
 support
In-Reply-To: <20151222121718.GB26290@tiger>
References: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
 <1450772120-18131-1-git-send-email-ilya@compulab.co.il>
 <1450772120-18131-2-git-send-email-ilya@compulab.co.il>
 <20151222121718.GB26290@tiger>
Message-ID: <56795937.6090903@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 12/22/15 14:17, Shawn Guo wrote:
> On Tue, Dec 22, 2015 at 10:15:19AM +0200, Ilya Ledvich wrote:

[...]

>> +/ {
>> +	model = "CompuLab CL-SOM-iMX7";
>> +	compatible = "compulab,cl-som-imx7", "fsl,imx7d";
>> +
>> +	memory {
>> +		reg = <0x80000000 0x10000000>; /* 256 MB - minimal configuration */
>> +	};
>> +
>> +	regulators {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
> 
> DT maintainers dislike this fake "simple-bus" container, and we were
> asked to put fixed regulator directly under root.  I fixed it up like
> below:
> 
> 	reg_usb_otg1_vbus: regulator-vbus {
> 		compatible = "regulator-fixed";
> 		regulator-name = "usb_otg1_vbus";
> 		regulator-min-microvolt = <5000000>;
> 		regulator-max-microvolt = <5000000>;
> 		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> 		enable-active-high;
> 	};
> 

Looks good! Thanks for adjusting this.

[...]

-- 
Regards,
Igor.
