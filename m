From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Fri, 6 Feb 2015 13:49:29 +0800
Subject: [PATCH 2/4] Documentation: dt-bindings: add dt binding info for
 hi6220
In-Reply-To: <54D3B541.1070404@cogentembedded.com>
References: <1423147620-5760-1-git-send-email-zhangfei.gao@linaro.org>
 <1423147620-5760-3-git-send-email-zhangfei.gao@linaro.org>
 <54D3B541.1070404@cogentembedded.com>
Message-ID: <CABQgh9Hx7_-vNg2nbju_mPEZMj6KB4Sj37mk6jqnj7AS2zOMLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 February 2015 at 02:24, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> diff --git a/Documentation/devicetree/bindings/usb/hi6220-usb.txt
>> b/Documentation/devicetree/bindings/usb/hi6220-usb.txt
>> new file mode 100644
>> index 0000000..e926364
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/hi6220-usb.txt
>> @@ -0,0 +1,50 @@
>> +Hisilicon hi6220  SoC USB controlle
>
>
>    Controller.
Yes, my mistake.
To prevent spelling error next time, will paste to google doc first
for the auto spelling check.

>
>> +-----------------------------
>> +
>> +usb controller is inherited from dwc2, refer dwc2.txt
>> +-----
>> +
>> +Required properties:
>> +- compatible: "hisilicon,hi6220-usb-phy"
>
>
>    PHY? I thought you were describing the USB controller.
my bad
should be compatible: "hisilicon,hi6220-usb"

>
>> +Refer to dwc2.txt for dwc2 usb properties
>> +
>> +
>> +phy:
change to PHY:
>> +-----
>> +
>> +Required properties:
>> +- compatible: "hisilicon,hi6220-usb-phy"
>> +- vcc-supply: phandle to the regulator that provides power to the PHY.
>> +- clocks: phandle to the PHY clock. Use as per Documentation/devicetree
>
>
>    Actually, it's phandle and clock specifier.
Change to
 - clocks: phandle and clock specifier of the PHY clock.

>
>> +  /bindings/clock/clock-bindings.txt
>> +- hisilicon,peripheral-syscon: phandle of syscon used to control
>> peripheral.
>> +- hisilicon,gpio_vbus_det: gpio of detecting vbus.
>> +- hisilicon,gpio_id_det: gpio of detecting id.
>
>
>    Hyphens are preferred over underscores in the prop names.
Change to
- hisilicon,gpio-vbus-det: gpio of detecting vbus.
- hisilicon,gpio-id-det: gpio of detecting id.

Thanks Sergei
