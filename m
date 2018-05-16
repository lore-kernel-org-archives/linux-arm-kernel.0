From: eric@anholt.net (Eric Anholt)
Date: Wed, 16 May 2018 18:51:39 +0100
Subject: [PATCH RFC 2/6] dt-bindings: hwmon: Add Raspberry Pi voltage
 sensor
In-Reply-To: <30fc5bac-0c4a-b2c4-a018-ea521510aaea@arm.com>
References: <1526477827-10859-1-git-send-email-stefan.wahren@i2se.com>
 <1526477827-10859-3-git-send-email-stefan.wahren@i2se.com>
 <30fc5bac-0c4a-b2c4-a018-ea521510aaea@arm.com>
Message-ID: <874lj7cwus.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robin Murphy <robin.murphy@arm.com> writes:

> On 16/05/18 14:37, Stefan Wahren wrote:
>> Recent VC4 firmware provides a hardware-independent way to retrieve the
>> under-voltage sensor on the following Raspberry Pi boards:
>>    - Raspberry Pi B+ (via GPIO on SoC)
>>    - Raspberry Pi A+ (via GPIO on SoC)
>>    - Raspberry Pi 2 B (via GPIO on SoC)
>>    - Raspberry Pi 3 B (via GPIO on port expander)
>>    - Raspberry Pi 3 B+ (via PMIC)
>> 
>> TODO:
>>    - try to make bcm2835 firmware a bus driver
>
> Do you actually need a DT binding? From the probe routine in patch 2 it 
> looks like this capability can be discovered dynamically by asking the 
> firmware, therefore it might be more straightforward for the firmware 
> driver itself to probe that and create a child device iff the feature is 
> present, which the hwmon driver can then bind to as a pure platform driver.

Agreed, let's skip doing this in DT.  I just switched the bcm2835-camera
driver over to not need DT, and I think you could do something similar
(and use the pdev->dev.parent to get at the firmware device).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180516/14e9e2c9/attachment.sig>
