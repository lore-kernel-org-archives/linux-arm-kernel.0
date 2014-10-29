From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 29 Oct 2014 12:03:34 +0900
Subject: [PATCH 11/15] sound: soc: poodle: make use of new locomo GPIO
 interface
In-Reply-To: <20141028145850.GU18557@sirena.org.uk>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-12-git-send-email-dbaryshkov@gmail.com>
 <20141028145850.GU18557@sirena.org.uk>
Message-ID: <CAAVeFuKgARoMFzf+663iP6cULs93d4WSQS8ESjUb9VcxguWurA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 11:58 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Oct 28, 2014 at 03:02:04AM +0300, Dmitry Eremin-Solenikov wrote:
>> Since LoCoMo driver has been converted to provide proper gpiolib
>> interface, make poodle ASoC platform driver use gpiolib API.
>
> Please use subject lines matching the style for the subsystem.
>
>> +     ret = gpio_request_array(poodle_gpios, ARRAY_SIZE(poodle_gpios));
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "gpio_request_array() failed: %d\n",
>> +                             ret);
>> +             return ret;
>> +     }
>
> I sense a need for devm_gpio_request_array() here.  Otherwise this looks
> fine - ideally it'd move to gpiod but moving to gpiolib is a clear win
> so no need to block on this.

I wish Dmitry took the opportunity to move this driver to the gpiod
API, especially since doing so would be trivial for this driver. Not a
critical requirement though, the present patch is already an
improvement. But if you want to do that last step, please have a look
at Documentation/gpio/consumer.txt and the "Platform Data" section of
Documentation/gpio/board.txt.
