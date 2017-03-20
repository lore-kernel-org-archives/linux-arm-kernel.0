From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 20 Mar 2017 20:56:04 +0100
Subject: [RFT PATCH 0/1] Meson GXBB: use pwm-leds on supported devices
In-Reply-To: <a5b18444-6158-7bc2-cb19-0b5a44ea9316@baylibre.com>
References: <20170318143728.16535-1-martin.blumenstingl@googlemail.com>
 <a5b18444-6158-7bc2-cb19-0b5a44ea9316@baylibre.com>
Message-ID: <CAFBinCCuNM1LSgtVr18A9=hsLNRYoaatVJ8ZshD9xzy1S1wi3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Mon, Mar 20, 2017 at 9:43 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 03/18/2017 03:37 PM, Martin Blumenstingl wrote:
>> This patch enables brightness support through the pwm-leds driver for
>> the GXBB devices which use GPIOAO_13 for their system/status LED.
>>
>> Affected devices are:
>> - NEXBOX A95X (GXBB, S905 variant)
>> - Odroid-C2
>> - the Tronsmart Vega S95 series (Meta, Pro, Telos)
>> - WeTek Hub
>> - WeTek Play 2
>>
>> unfortunately my GXBB board (a Tronsmart Vega S95 Meta clone) is not
>> working anymore, so I can't test this at all.
>> if it works on one of the devices then we can probably assume that it
>> works fine on all other devices as well.
>>
>>
>> Martin Blumenstingl (1):
>>   ARM64: dts: meson-gxbb: convert devices to use pwm-leds
>>
>>  .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 18 +++++++++++----
>>  .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 16 ++++++++++---
>>  .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      | 17 ++++++++++----
>>  .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      | 19 +++++++++++----
>>  .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts    | 27 ++++++++++++++++------
>>  5 files changed, 74 insertions(+), 23 deletions(-)
>>
>
> Hi Martin,
>
> I'm concerned about how the LED is managed by the firmware.
> The system led is usually managed by the firmware and color is changed
> when in suspend or poweroff mode.
> But I'm not sure of the behavior if the pin mode is set to PWM.
>
> Can you check this ?
I have tested this on the Khadas VIM before: it seems to work fine
(the LED changes it's color when the device is powered off, even if a
kernel which used pwm-leds was booted before).
it might depend on the bootloader / firmware though - but I guess the
only way to find out is by testing this.


Regards,
Martin


[0] https://github.com/khadas/linux/commit/94602ef5562978a8d8b5c7770c113074a714dbdb
