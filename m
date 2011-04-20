From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2011 14:38:01 +0200
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <D3BCC8A3-7570-49F2-838C-A2B1899B0519@niasdigital.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
	<6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
	<20110419093855.36910400@lxorguk.ukuu.org.uk>
	<D3BCC8A3-7570-49F2-838C-A2B1899B0519@niasdigital.com>
Message-ID: <BANLkTi=M3FxU6vv_aq1rLTmXQCGps=hC=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/20 Ben Nizette <bn@niasdigital.com>:
> On 19/04/2011, at 6:38 PM, Alan Cox wrote:
>> Leaving aside the current input/output and on/off bits I would go for
>> being able to do
>>
>> ? ? ? gpio_get_property(gpio, GPIO_BIAS, GPIO_BIAS_WHATEVER);
>> ? ? ? gpio_set_property(gpio, GPIO_BIAS, GPIO_BIAS_WHATEVER_ELSE);
>
> Yeah I'm all for that so long as the capability constants are defined by the gpio
> provider, eg <linux/gpio/mygpioexpander.h>. ?There's no way gpiolib should be
> keeping a big ole list of every possible config option for every gpio provider.

OK I buy that. I will refactor this solution to some opaque call instead
and start from there.

>?Well, maybe gpiolib can know about the options (eg GPIO_BIAS) so long
> as it doesn't have to enumerate every possible value.

I will drop that even, one parameter is better than two if one of them
is custom nevertheless. What difference does it make..

Yours,
Linus Walleij
