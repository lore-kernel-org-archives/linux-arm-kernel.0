From: david@lechnology.com (David Lechner)
Date: Mon, 24 Oct 2016 21:56:50 -0500
Subject: [PATCH 5/5] ARM: dts: Add LEGO MINDSTORTMS EV3 dts
In-Reply-To: <1593441f-d147-4c91-8aab-8622dd8ced19@lechnology.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
 <1477075018-20176-6-git-send-email-david@lechnology.com>
 <b0022fad-a96e-86d4-71ba-2b803e5421fe@ti.com>
 <1593441f-d147-4c91-8aab-8622dd8ced19@lechnology.com>
Message-ID: <aa18572c-2c9d-ee24-dcd2-8627ab7a9b83@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2016 10:50 AM, David Lechner wrote:
> On 10/24/2016 06:58 AM, Sekhar Nori wrote:
>> On Saturday 22 October 2016 12:06 AM, David Lechner wrote:
>>> +};
>>> +
>>> +&spi1 {
>>> +    status = "okay";
>>> +    pinctrl-names = "default";
>>> +    pinctrl-0 = <&spi1_pins>, <&spi1_cs0_pin>;
>>> +
>>> +    /* TODO: LCD Display goes here */
>>
>> Add this node when you actually have display working.
>
> What if we set this up as a spidev node instead? This way the display
> could be used from userspace without a driver.
>

To answer my own question, it seems that specifying "spidev" in 
devicetree is frowned upon since it does not "describe the hardware".
