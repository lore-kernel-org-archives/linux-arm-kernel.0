From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Tue, 21 Jun 2016 15:30:17 +0530
Subject: [PATCH v2 1/3] Documentation: DT: Add iproc-static-adc binding
In-Reply-To: <20160620180458.GA10171@rob-hp-laptop>
References: <1466330790-2820-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1466330790-2820-2-git-send-email-raveendra.padasalagi@broadcom.com>
 <20160620180458.GA10171@rob-hp-laptop>
Message-ID: <CAAFb_voGMfQvvW5yknv0n73KTEh7e_vy_UuKf4FL2+iUz8t6rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Please find my reply inline.

Regards,
Raveendra

On Mon, Jun 20, 2016 at 11:34 PM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Jun 19, 2016 at 03:36:28PM +0530, Raveendra Padasalagi wrote:
>> The patch adds devicetree binding document for broadcom's
>> iproc-static-adc controller driver.
>>
>> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  .../bindings/iio/adc/brcm,iproc-static-adc.txt     | 43 ++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
>> new file mode 100644
>> index 0000000..1de0dfa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
>> @@ -0,0 +1,43 @@
>> +* Broadcom's IPROC Static ADC controller
>> +
>> +Required properties:
>> +
>> +- compatible: Must be "brcm,iproc-static-adc"
>> +
>
>> +- #address-cells: Specify the number of u32 entries needed in child nodes.
>> +  Should set to 1.
>> +
>> +- #size-cells: Specify number of u32 entries needed to specify child nodes size
>> +  in reg property. Should set to 1.
>
> Why are these needed? What child nodes can you have?

Yes, these are not needed. ADC can't have any child nodes.

I will fix it in the next patch. Thanks.

>> +
>> +- adc-syscon: Handler of syscon node defining physical base address of the
>> +  controller and length of memory mapped region.
>> +
>> +- #io-channel-cells = <1>; As ADC has multiple outputs
>> +  refer to Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
>> +
>> +- clocks: Clock used for this block.
>> +
>> +- clock-names: Clock name should be given as tsc_clk.
>> +
>> +- interrupts: interrupt line number.
>> +
>> +For example:
>> +
>> +     ts_adc_syscon: ts_adc_syscon at 180a6000 {
>> +             compatible = "brcm,iproc-ts-adc-syscon","syscon";
>> +             reg = <0x180a6000 0xc30>;
>> +     };
>> +
>> +     adc: adc at 180a6000 {
>> +             compatible = "brcm,iproc-static-adc";
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             adc-syscon = <&ts_adc_syscon>;
>> +             #io-channel-cells = <1>;
>> +             io-channel-ranges;
>> +             clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
>> +             clock-names = "tsc_clk";
>> +             interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
>> +             status = "disabled";
>> +     };
>> --
>> 1.9.1
>>
