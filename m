From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Sep 2016 10:38:52 -0600
Subject: [PATCH 1/3] dt-bindings: Add a binding for the RPi firmware GPIO
 driver.
In-Reply-To: <1903581972.81288.e9d48a65-997b-4986-a9d0-10632895df40.open-xchange@email.1und1.de>
References: <20160919161314.25858-1-eric@anholt.net>
 <1903581972.81288.e9d48a65-997b-4986-a9d0-10632895df40.open-xchange@email.1und1.de>
Message-ID: <fa11c543-2ad3-b2ae-f816-62a1acd42911@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2016 12:39 PM, Stefan Wahren wrote:
> Hi Eric,
>
>> Eric Anholt <eric@anholt.net> hat am 19. September 2016 um 18:13 geschrieben:
>>
>>
>> The RPi firmware exposes all of the board's GPIO lines through
>> property calls.  Linux chooses to control most lines directly through
>> the pinctrl driver, but for the FXL6408 GPIO expander on the Pi3, we
>> need to access them through the firmware.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  .../bindings/gpio/gpio-raspberrypi-firmware.txt    | 22
>> ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/gpio/gpio-raspberrypi-firmware.txt
>>
>> diff --git
>> a/Documentation/devicetree/bindings/gpio/gpio-raspberrypi-firmware.txt
>> b/Documentation/devicetree/bindings/gpio/gpio-raspberrypi-firmware.txt
>> new file mode 100644
>> index 000000000000..2b635c23a6f8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-raspberrypi-firmware.txt
>> @@ -0,0 +1,22 @@
>> +Raspberry Pi power domain driver
>> +
>> +Required properties:
>> +
>> +- compatible:		Should be "raspberrypi,firmware-gpio"
>
> i think the compatible should be more specific like
>
> raspberrypi,rpi3-firmware-gpio
>
> and all information which aren't requestable from the firmware should be stored
> in a info structure. This makes the driver easier to extend in the future by
> adding new compatibles and their info structures.

Is this actually specific to the Pi3 at all? Isn't the FW the same 
across all Pis; the part that's specific to the Pi3 is whether it's 
useful to use that API?

As such, I'd suggest just raspberrypi,firmware-gpio as the compatible value.
