From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 23 Jun 2017 10:22:24 +0200
Subject: [PATCH v3 1/3] dt-bindings: arm: amlogic: Add SoC information
 bindings
In-Reply-To: <20170622212449.wsck475jxabawqsv@rob-hp-laptop>
References: <1497441946-24379-1-git-send-email-narmstrong@baylibre.com>
 <1497441946-24379-2-git-send-email-narmstrong@baylibre.com>
 <20170622212449.wsck475jxabawqsv@rob-hp-laptop>
Message-ID: <c62ace5a-f977-6f07-2e02-e20aac94bcb9@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2017 11:24 PM, Rob Herring wrote:
> On Wed, Jun 14, 2017 at 02:05:44PM +0200, Neil Armstrong wrote:
>> Add bindings for the SoC information register of the Amlogic SoCs.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/arm/amlogic.txt | 29 +++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
>> index 5c01e65..a6d8754 100644
>> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
>> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
>> @@ -60,3 +60,32 @@ Board compatible values (alphabetically, grouped by SoC):
>>    - "amlogic,q201" (Meson gxm s912)
>>    - "kingnovel,r-box-pro" (Meson gxm S912)
>>    - "nexbox,a1" (Meson gxm s912)
>> +
>> +Amlogic Meson Firmware registers Interface
>> +------------------------------------------
>> +
>> +The Meson SoCs have a register bank with status and data shared with the
>> +secure firmware.
>> +
>> +Required properties:
>> + - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-ao-secure", "syscon"
>> +
>> +Properties should indentify components of this register interface :
>> +
>> +Meson GX SoC Information
>> +------------------------
>> +A firmware register encodes the SoC type, package and revision information on
>> +the Meson GX SoCs.
>> +If present, the following property should be added :
>> +
>> +Optional properties:
>> +  - has-chip-id: If present, the interface gives the current SoC version.
> 
> amlogic,has-chip-id

OK, thanks I'll send a v3.1 with this small change.

Neil

> 
> With that,
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
>> +
>> +Example
>> +-------
>> +
>> +ao-secure at 140 {
>> +	compatible = "amlogic,meson-gx-ao-secure", "syscon";
>> +	reg = <0x0 0x140 0x0 0x140>;
>> +	has-chip-id;
>> +};
>> -- 
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
