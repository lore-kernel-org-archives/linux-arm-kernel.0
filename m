From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 20 Apr 2011 23:40:18 +0900
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <BANLkTint6DGgosVkjK-sveyA9SL9WVS4Mg@mail.gmail.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
	<6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
	<20110419093855.36910400@lxorguk.ukuu.org.uk>
	<BANLkTimqpP2k1tBvRL0BXs9E-Q=3bh0C7Q@mail.gmail.com>
	<BANLkTint6DGgosVkjK-sveyA9SL9WVS4Mg@mail.gmail.com>
Message-ID: <BANLkTinv-MSg5Sobg2X1cJpAwPkM1Gevcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 11:26 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> On Tue, Apr 19, 2011 at 4:51 PM, Kyungmin Park <kmpark@infradead.org> wrote:
>>>
>>> Leaving aside the current input/output and on/off bits I would go for
>>> being able to do
>>>
>>> ? ? ? ?gpio_get_property(gpio, GPIO_BIAS, GPIO_BIAS_WHATEVER);
>>> ? ? ? ?gpio_set_property(gpio, GPIO_BIAS, GPIO_BIAS_WHATEVER_ELSE);
>>
>> One more consideration, not mentioned previous time, is that pin
>> configuration for power down mode.
>> Samsung SoCs has retention GPIO configurations at sleep (suspend)
>> mode. and restore it at resume time.
>> it's need to reduce power and proper operation after suspend.
>>
> I have a little confusion. In ARM SoC, a lot of pins are used as
> multi-functions.
>
> Before suspend, it may be configured as some function that isn't GPIO.
> Is it a goal
> that avoid declaring gpio_request() for suspend and updating the setting of pin?

E.g., When WiFi is turn on and system goes the sleep, wifi should be
turn on. For this it should be configure the power down gpio
configuration properly. Its' different that call the gpio_set_value
function.

One more, even though some pins are used for other purpose instead of
GPIO. It needs to be configure as input or output at power down mode
registers.

Thank you,
Kyungmin Park

>
> Linus,
> Are these two patches are post in mailing list? I can't find your
> second patch in this
> patch series?
>
