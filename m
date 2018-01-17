From: eric@anholt.net (Eric Anholt)
Date: Wed, 17 Jan 2018 11:37:03 -0800
Subject: [PATCH V3 1/2] dt-bindings: bcm283x: Fix register ranges of
 bcm2835-i2s
In-Reply-To: <47138b75-1d6a-1692-636b-e37a87d68842@i2se.com>
References: <1512818795-1441-1-git-send-email-stefan.wahren@i2se.com>
 <1512818795-1441-2-git-send-email-stefan.wahren@i2se.com>
 <47138b75-1d6a-1692-636b-e37a87d68842@i2se.com>
Message-ID: <87a7xcmg4g.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Am 09.12.2017 um 12:26 schrieb Stefan Wahren:
>> Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
>> the bcm2835-i2s requires a clock as DT property. Unfortunately
>> the necessary DT change has never been applied. While we are at it
>> also fix the first PCM register range to cover the PCM_GRAY register.
>>
>> This patch only fixes the affected dt-bindings.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Reviewed-by: Eric Anholt <eric@anholt.net>
>> ---
>>   Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt   | 4 ++--
>>   Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt | 9 ++++-----
>>   2 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
>> index baf9b34..b6a8cc0 100644
>> --- a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
>> +++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
>> @@ -74,8 +74,8 @@ Example:
>>   
>>   bcm2835_i2s: i2s at 7e203000 {
>>   	compatible = "brcm,bcm2835-i2s";
>> -	reg = <	0x7e203000 0x20>,
>> -	      < 0x7e101098 0x02>;
>> +	reg = <	0x7e203000 0x24>;
>> +	clocks = <&clocks BCM2835_CLOCK_PCM>;
>>   
>>   	dmas = <&dma 2>,
>>   	       <&dma 3>;
>> diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
>> index 65783de..7bb0362 100644
>> --- a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
>> +++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
>> @@ -2,9 +2,8 @@
>>   
>>   Required properties:
>>   - compatible: "brcm,bcm2835-i2s"
>> -- reg: A list of base address and size entries:
>> -	* The first entry should cover the PCM registers
>> -	* The second entry should cover the PCM clock registers
>> +- reg: Should contain PCM registers location and length.
>> +- clocks: the (PCM) clock to use
>>   - dmas: List of DMA controller phandle and DMA request line ordered pairs.
>>   - dma-names: Identifier string for each DMA request line in the dmas property.
>>     These strings correspond 1:1 with the ordered pairs in dmas.
>> @@ -16,8 +15,8 @@ Example:
>>   
>>   bcm2835_i2s: i2s at 7e203000 {
>>   	compatible = "brcm,bcm2835-i2s";
>> -	reg = <0x7e203000 0x20>,
>> -	      <0x7e101098 0x02>;
>> +	reg = <0x7e203000 0x24>;
>> +	clocks = <&clocks BCM2835_CLOCK_PCM>;
>>   
>>   	dmas = <&dma 2>,
>>   	       <&dma 3>;
>
> gentle ping ...

Still looking for a DT ack, here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180117/008cc1ba/attachment-0001.sig>
