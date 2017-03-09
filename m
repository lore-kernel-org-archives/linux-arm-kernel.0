From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 9 Mar 2017 20:36:52 +0100
Subject: [PATCH] ARM64: dts: meson-gxbb-odroidc2: enable USB Host Nodes
In-Reply-To: <CANAwSgTuP_OGp+0sdR9sVuq-SOkBfQxYKONZPB7Vo=+GFdrHfw@mail.gmail.com>
References: <1488918961-4666-1-git-send-email-linux.amoon@gmail.com>
 <CANAwSgTUPpYvFWcZOf+j6K+1rDZJNUeu9K1fGAB8TC6TgzRXCg@mail.gmail.com>
 <0204bbde-c437-e11b-cb3b-d9f4b55a5810@baylibre.com>
 <CANAwSgTuP_OGp+0sdR9sVuq-SOkBfQxYKONZPB7Vo=+GFdrHfw@mail.gmail.com>
Message-ID: <CAFBinCCGpA-RrJRgK5NJc6cm1qWhBVYF+hUvY1YrD3oFvmVYoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anand,

On Thu, Mar 9, 2017 at 6:58 PM, Anand Moon <linux.amoon@gmail.com> wrote:
>> Hi Anand,
>>
>> For this specific use case, the only way to manage this is to use the Work-In-Progress
>> Power Sequence Library proposer by Peter Chen at :
>> https://lkml.org/lkml/2016/11/13/315
>>
>> Since this is the USB Hub reset link and has no direct link with either the USB controller
>> or the USB PHY, and the USB Hus cannot be modeled (yet ?) in the DT.
>>
>> One intermediate, but crappy, solution would be to add a GPIO hog until the power
>> sequence code has been merged, with a proper big fat warning in the dts file.
>>
>> You can find doc about the gpio-hog in :
>> Documentation/devicetree/bindings/gpio/gpio.txt
>>
>> It should look like :
>>
>> usb-hub {
>>         gpio-hog;
>>         gpios = <GPIOAO_4 GPIO_ACTIVE_HIGH>;
>>         output-high;
>>         line-name = "usb-hub-reset";
>> };
>>
>> in the gpio_ao controller node.
>>
>> Neil
>
> Thanks for this input.
>
> I will check this series of patches, and work on this new approach.
you might want to look at the following two patches as well: [0] and [1]
I didn't test them as I don't have an Odroid-C2 but they should work
with the series that Neil has mentioned. feel free to take my patches
and fix them where needed


Regards,
Martin

[0] https://github.com/xdarklight/linux/commit/f0bc8f826b465fbf24279ce78654b65282790dc6
[1] https://github.com/xdarklight/linux/commit/7b5a69bf5bad992249aa39a96360fe90ccde9cd5
