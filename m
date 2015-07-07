From: eric@anholt.net (Eric Anholt)
Date: Tue, 07 Jul 2015 13:13:48 -0700
Subject: [PATCH v3 1/7] dt/bindings: Add binding for the Raspberry Pi
 clock provider
In-Reply-To: <20150609100326.GQ2982@x1>
References: <1433807940-15328-1-git-send-email-eric@anholt.net>
 <20150609100326.GQ2982@x1>
Message-ID: <87egkj914z.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee Jones <lee@kernel.org> writes:

> If I were the Clock Maintainer, I would have probably missed this
> patch.  You _must_ intimate which subsystem you are submitting to.
>
>> The hardware clocks are not controllable by the ARM, so we have to
>> make requests to the firmware to do so from the VPU side.  This will
>> let us replace fixed clocks in our DT with actual clock control (and
>> correct frequency information).
>> 
>> v2: Include the dt-bindings header in this commit instead of the next
>>     one.  Make the clock indices match the firmware clock IDs.  Rename
>>     the binding's compat string.  Move the firmware phandle to be
>>     under a vendor-specific namespace.
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  .../clock/raspberrypi,bcm2835-firmware-clocks.txt  | 25 ++++++++++++++++++++++
>>  include/dt-bindings/clk/raspberrypi.h              | 23 ++++++++++++++++++++
>>  2 files changed, 48 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,bcm2835-firmware-clocks.txt
>>  create mode 100644 include/dt-bindings/clk/raspberrypi.h
>> 
>> diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,bcm2835-firmware-clocks.txt b/Documentation/devicetree/bindings/clock/raspberrypi,bcm2835-firmware-clocks.txt
>> new file mode 100644
>> index 0000000..0972602
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/raspberrypi,bcm2835-firmware-clocks.txt
>> @@ -0,0 +1,25 @@
>> +Raspberry Pi firmware clock provider.
>> +
>> +The Raspberry Pi architecture doesn't provide direct access to the
>> +CLOCKMAN peripheral from the ARM side, so Linux has to make requests
>> +to the VPU firmware to program them.
>> +
>> +This binding uses the common clock binding:
>> +Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Required properties:
>> +- compatible:		Should be "raspberrypi,bcm2835-firmware-clocks"
>> +
>> +- #clock-cells:		Shall have value <1>.  The permitted clock-specifier
>> +			  values can be found in
>> +			  include/dt-bindings/clk/raspberrypi.h.
>> +
>> +- raspberrypi,firmware:	Phandle to the firmware driver node.
>
> I think 'firmware' is a candidate for a generic phandle name.

Stephen Warren asked in the last version that I change it from
"firmware" to "raspberrypi,firmware", which made sense to me since we're
not some core infrastructure using these references.  Which should it
be?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150707/7c611a25/attachment.sig>
