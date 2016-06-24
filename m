From: bruherrera@gmail.com (Bruno Herrera)
Date: Fri, 24 Jun 2016 15:51:18 -0300
Subject: [PATCH 3/3] dt-bindings: Document the STM32 USB OTG DWC2 core
 binding
In-Reply-To: <20160624154118.GA4598@rob-hp-laptop>
References: <1466562349-5043-1-git-send-email-bruherrera@gmail.com>
 <1466562349-5043-3-git-send-email-bruherrera@gmail.com>
 <20160624154118.GA4598@rob-hp-laptop>
Message-ID: <CAF3+Tqe05kXExob_62w80BBbXz6p01-WwXM1+R6ecp0JtsgviA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2016 at 12:41 PM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jun 21, 2016 at 11:25:49PM -0300, Bruno Herrera wrote:
>> Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
>> index 20a68bf..79e5370 100644
>> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
>> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
>> @@ -11,6 +11,7 @@ Required properties:
>>    - "lantiq,arx100-usb": The DWC2 USB controller instance in Lantiq ARX SoCs;
>>    - "lantiq,xrx200-usb": The DWC2 USB controller instance in Lantiq XRX SoCs;
>>    - snps,dwc2: A generic DWC2 USB controller with default parameters.
>> +  - st,stm32-fsotg: The DWC2 USB controller instance in STM32F4 SoCs in FS mode;
>
> This should go above snps,dwc2.
>
Ok, tks!

> What determines FS mode vs. HS?
>
Its more HW design decision.
STM32F429/439/469 has two OTG controllers, one that is FS (internal
phy) and other that is HS (but can also work in FS mode with
internal/external phy)
This bind work with both cores FS and HS working with the internal PHY.

I tested the following configurations:
1 - STM32F429I-DISCOv1 board (OTG HS working in FS mode internal PHY)
2 - STM32F469I-DISCO board (OTG FS)

I did not tested OTG HS core working in FS mode with external PHY (I2C).

>>  - reg : Should contain 1 register range (address and length)
>>  - interrupts : Should contain 1 interrupt
>>  - clocks: clock provider specifier
>> --
>> 2.7.4 (Apple Git-66)
>>
