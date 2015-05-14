From: eric@anholt.net (Eric Anholt)
Date: Thu, 14 May 2015 02:57:43 -0700
Subject: [PATCH 1/3 v2] dt/bindings: Add binding for the Raspberry Pi
 firmware driver
In-Reply-To: <20150514084039.GC22418@x1>
References: <1431543609-19646-1-git-send-email-eric@anholt.net>
 <1431543609-19646-2-git-send-email-eric@anholt.net>
 <20150514084039.GC22418@x1>
Message-ID: <878ucrbhwo.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee Jones <lee@kernel.org> writes:

> On Wed, 13 May 2015, Eric Anholt wrote:
>
>> This driver will provide support for calls into the firmware that will
>> be used by other drivers like cpufreq and vc4.
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>> 
>> v2: Improve commit message, point to mailbox.txt for how mboxes work.
>> 
>>  .../devicetree/bindings/arm/bcm/raspberrypi,firmware.txt | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,firmware.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,firmware.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,firmware.txt
>> new file mode 100644
>> index 0000000..33b0043
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,firmware.txt
>> @@ -0,0 +1,16 @@
>> +Raspberry Pi VideoCore firmware driver
>> +
>> +Required properties:
>> +
>> +- compatible:		Should be "rasbperrypi,firmware"
>> +- mboxes:		Single-entry list which specifies which mailbox
>> +			  controller and channel is used.  See
>> +			  Documentation/devicetree/bindings/mailbox/mailbox.txt
>> +			  for the semantics of this property
>
> That's not what it looks like to me.  There is no mention of channels
> in a 0 cell property.  Keep it simple.  How about:
>
> Phandle to the firmware device's Mailbox.
> (See: ../mailbox/mailbox.txt for more information)

Sounds good to me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150514/43d070d7/attachment.sig>
