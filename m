From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 20 Jul 2015 10:54:05 +0200
Subject: [PATCH 6/7] Documentation: atmel-quadspi: add binding file for
 Atmel QSPI driver
In-Reply-To: <55A8EAAE.6010506@cogentembedded.com>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com>
 <f4bb1c68fcc19b3642110ab0ef9850d6eeca3112.1437059658.git.cyrille.pitchen@atmel.com>
 <55A8EAAE.6010506@cogentembedded.com>
Message-ID: <55ACB72D.60506@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

thanks for the review. For the next series I've removed all references to
"qspi" in the node example but the one from the compatible string.
I've also removed the leading 0 in the size of the second memory region.

Best Regards,

Cyrille

Le 17/07/2015 13:44, Sergei Shtylyov a ?crit :
> Hello.
> 
> On 7/16/2015 6:27 PM, Cyrille Pitchen wrote:
> 
>> This patch documents the DT bindings for the driver of the Atmel QSPI
>> controller embedded inside sama5d2x SoCs.
> 
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>> ---
>>   .../devicetree/bindings/mtd/atmel-quadspi.txt      | 29 ++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> 
>> diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
>> new file mode 100644
>> index 000000000000..a0d60ac7ae10
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
>> @@ -0,0 +1,29 @@
>> +* Atmel Quad Serial Peripheral Interface (QSPI)
>> +
>> +Required properties:
>> +  - compatible : Should be "atmel,sama5d2-qspi"
>> +  - reg : the first contains the register location and length,
>> +          the second contains the memory mapping address and length
>> +  - interrupts : Should contain the interrupt for the device
>> +  - clocks : The clock needed by the QSPI controller
>> +  - #address-cells : should be 1
>> +  - #size-cells : should be 0
>> +
>> +Example:
>> +
>> +qspi0: qspi at f0020000 {
> 
>     Once again, the ePAPR standard tells up to call the node just "spi", not "qspi".
> 
>> +    compatible = "atmel,sama5d2-qspi";
>> +    reg = <0xf0020000 0x100>,
>> +          <0xd0000000 0x08000000>;
> 
>    Either you use the leading zeroes or you don't. :-)
> 
> [...]
> 
> MBR, Sergei
> 
