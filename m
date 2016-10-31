From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Mon, 31 Oct 2016 13:12:43 -0700
Subject: [PATCH v1 1/3] dt-bindings: Document Broadcom OTP controller
 driver
In-Reply-To: <20161031013848.4vi2544tb5cs65nk@rob-hp-laptop>
References: <1477336324-10543-1-git-send-email-jonathan.richardson@broadcom.com>
 <1477336324-10543-2-git-send-email-jonathan.richardson@broadcom.com>
 <20161031013848.4vi2544tb5cs65nk@rob-hp-laptop>
Message-ID: <350b2f50-29dd-6a96-62af-b5c973322298@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16-10-30 06:38 PM, Rob Herring wrote:
> On Mon, Oct 24, 2016 at 12:12:02PM -0700, Jonathan Richardson wrote:
>> From: Jonathan Richardson <jonathar@broadcom.com>
>>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> Signed-off-by: Oza Pawandeep <oza@broadcom.com>
>> Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
>> ---
>>  Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt b/Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt
>> new file mode 100644
>> index 0000000..6462e12
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/brcm,ocotp.txt
>> @@ -0,0 +1,17 @@
>> +Broadcom OTP memory controller
>> +
>> +Required Properties:
>> +- compatible: "brcm,ocotp" for the first generation Broadcom OTPC which is used
>> +  in Cygnus and supports 32 bit read/write. Use "brcm,ocotp-v2" for the second
>> +  generation Broadcom OTPC which is used in SoC's such as Stingray and supports
>> +  64-bit read/write.
> 
> These should be SoC specific. While I'd guess this block is simple 
> enough, having the SoC can define what all the bits are. Yes, there is a 
> binding to define those, but you may not use that.

Hi Rob. This block isn't SoC specific. It is used on multiple SoC's.
There are older SoC's using v1 that we may upstream drivers for in the
future. v1 isn't specific to cygnus/iproc and v2 isn't specific to stingray.

> 
> 
>> +- reg: Base address of the OTP controller.
>> +- brcm,ocotp-size: Amount of memory available, in 32 bit words
>> +
>> +Example:
>> +
>> +otp: otp at 0301c800 {
>> +	compatible = "brcm,ocotp";
>> +	reg = <0x0301c800 0x2c>;
>> +	brcm,ocotp-size = <2048>;
>> +};
>> -- 
>> 1.9.1
>>
