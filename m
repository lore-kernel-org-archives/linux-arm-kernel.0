From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 4 May 2016 09:11:58 -0700
Subject: [PATCH 1/2] dt-bindings: arm,gic: Indtroduce optional property
 'arm,msi-offset-spi' for gicv2m
In-Reply-To: <CAMsMSK_jwd6OMMJ8DfAckVJgav9U6p-oz9YcinUinaqj2xdwAA@mail.gmail.com>
References: <1462319245-32532-1-git-send-email-ray.jui@broadcom.com>
 <1462319245-32532-2-git-send-email-ray.jui@broadcom.com>
 <CAMsMSK_jwd6OMMJ8DfAckVJgav9U6p-oz9YcinUinaqj2xdwAA@mail.gmail.com>
Message-ID: <3997ed69-760a-9bc1-a451-d07323a6e163@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/4/2016 8:57 AM, Chris Brand wrote:
> You have a typo in the subject line - "Indtroduce".

Thanks, but now this patch will be gone based on review comments from 
Marc on PATCH 2/2.

>
> Chris
>
> On Tue, May 3, 2016 at 4:47 PM, Ray Jui <ray.jui@broadcom.com> wrote:
>> Update the GICv2m binding document by adding an optional property
>> 'arm,msi-offset-spi'.
>>
>> Some implementations of gicv2m have an erratum where the MSI data is
>> the SPI number subtracted by an offset. This is required for the
>> correct MSI interrupt to be triggered.
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>>  Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
>> index 793c20f..550960f 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
>> @@ -140,6 +140,12 @@ Optional properties:
>>                       value, this property should contain the number of
>>                       SPIs assigned to the frame, overriding the HW value.
>>
>> +- arm,msi-offset-spi: Some implementations of gicv2m have an erratum where
>> +                     the MSI data is the SPI number subtracted by an offset.
>> +                     This is required for the correct MSI interrupt to be
>> +                     triggered. This property should contain the required
>> +                     offset.
>> +
>>  Example:
>>
>>         interrupt-controller at e1101000 {
>> --
>> 2.1.4
>>
