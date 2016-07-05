From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Tue, 5 Jul 2016 09:30:08 +0200
Subject: [PATCH 2/4] dt-bindings: Document the STM32 reset bindings
In-Reply-To: <1467653766.2224.76.camel@pengutronix.de>
References: <1467640052-6770-1-git-send-email-gabriel.fernandez@st.com>
 <1467640052-6770-2-git-send-email-gabriel.fernandez@st.com>
 <1467653766.2224.76.camel@pengutronix.de>
Message-ID: <577B6200.3070406@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 07/04/2016 07:36 PM, Philipp Zabel wrote:
> Am Montag, den 04.07.2016, 15:47 +0200 schrieb gabriel.fernandez at st.com:
>> From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>
>> This adds documentation of device tree bindings for the
>> STM32 reset controller.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> The way I understand Documentation/SubmittingPatches, this should also
> have your Signed-off-by.
ok

>> ---
>>   .../devicetree/bindings/reset/st,stm32-rcc.txt     | 50 ++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt b/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
>> new file mode 100644
>> index 0000000..333080c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
>> @@ -0,0 +1,50 @@
>> +STMicroelectronics STM32 Peripheral Reset Controller
>> +====================================================
>> +
>> +The RCC IP is both a reset and a clock controller. This documentation only
>> +documents the reset part.
>> +
>> +Please also refer to reset.txt in this directory for common reset
>> +controller binding usage.
>> +
>> +Required properties:
>> +- compatible: Should be "st,stm32-rcc"
>> +- reg: should be register base and length as documented in the
>> +  datasheet
>> +- #reset-cells: 1, see below
>> +
>> +example:
>> +
>> +rcc: reset at 40023800 {
>> +	#reset-cells = <1>;
>> +	compatible = "st,stm32-rcc";
>> +	reg = <0x40023800 0x400>;
>> +};
>> +
>> +Specifying softreset control of devices
>> +=======================================
>> +
>> +Device nodes should specify the reset channel required in their "resets"
>> +property, containing a phandle to the reset device node and an index specifying
>> +which channel to use.
>> +The index is the bit number within the RCC registers bank, starting from RCC
>> +base address.
>> +It is calculated as: index = register_offset / 4 * 32 + bit_offset.
>> +Where bit_offset is the bit offset within the register.
>> +For example, for CRC reset:
>> +  crc = AHB1RSTR_offset / 4 * 32 + CRCRST_bit_offset = 0x10 / 4 * 32 + 12 = 140
> I see you decided to keep the register offset encoded in the reset
> index.
>
>> +
>> +To simplify the usagen and to share bit definition with the clock driver of
> s/usagen/usage/
ok

>> +the RCC IP, macros are available to generate the index in human-readble
>> +format.
>> +
>> +For STM32F4 series, the macro are available here:
>> + - include/dt-bindings/mfd/stm32f4-rcc.h
> If DT and ARM/STI and maintainers agree with the binding and header
> macros, I'm inclined to take patches 1-3.
>
> regards
> Philipp
>

Thanks!

Best Regards

Gabriel
