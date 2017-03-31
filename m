From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 31 Mar 2017 16:10:30 +0200
Subject: [PATCH 2/3] dt-bindings: arm: amlogic: Add SoC information
 bindings
In-Reply-To: <CAK8P3a199j=7mb=CMgROvaOCVU8=kYda9wkvG3O4rtqweSyC0g@mail.gmail.com>
References: <1490950079-10145-1-git-send-email-narmstrong@baylibre.com>
 <1490950079-10145-3-git-send-email-narmstrong@baylibre.com>
 <CAK8P3a199j=7mb=CMgROvaOCVU8=kYda9wkvG3O4rtqweSyC0g@mail.gmail.com>
Message-ID: <4ab7d4ee-e805-69f1-b76b-b827b46285bd@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2017 03:44 PM, Arnd Bergmann wrote:
> On Fri, Mar 31, 2017 at 10:47 AM, Neil Armstrong
> <narmstrong@baylibre.com> wrote:
>> Add bindings for the SoC information register of the Amlogic SoCs.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/arm/amlogic.txt | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
>> index bfd5b55..b850985 100644
>> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
>> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
>> @@ -52,3 +52,23 @@ Board compatible values:
>>    - "amlogic,q201" (Meson gxm s912)
>>    - "nexbox,a95x" (Meson gxbb or Meson gxl s905x)
>>    - "nexbox,a1" (Meson gxm s912)
>> +
>> +Amlogic Meson GX SoCs Information
>> +----------------------------------
>> +
>> +The Meson SoCs have a Product Register that allows to retrieve SoC type,
>> +package and revision information. If present, a device node for this register
>> +should be added.
>> +
>> +Required properties:
>> +  - compatible: For Meson GX SoCs, must be "amlogic,meson-gx-socinfo".
>> +  - reg: Base address and length of the register block.
>> +
>> +Examples
>> +--------
>> +
>> +       chipid at 220 {
>> +               compatible = "amlogic,meson-gx-socinfo";
>> +               reg = <0x0 0x00220 0x0 0x4>;
>> +       };
>> +
> 
> The register location would hint that this is in the middle of some block of
> random registers, i.e. a syscon or some unrelated device.
> 
> Are you sure that "socinfo" is the actual name of the IP block and that
> it only has a single 32-bit register?
> 
>      Arnd
> 

Hi Arnd,

I'm sorry I did not find any relevant registers in the docs or source code describing
it in a specific block of registers, and no close enough register definitions either.
They may be used by the secure firmware I imagine.

For the register name, Amlogic refers it to "cpu_version" in their code, but it really
gives some details on the whole SoC and package, and socinfo seems better.

Neil
