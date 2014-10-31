From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Oct 2014 10:52:22 +0100
Subject: [PATCH 11/15] sound: soc: poodle: make use of new locomo GPIO
 interface
In-Reply-To: <CAAVeFuKgARoMFzf+663iP6cULs93d4WSQS8ESjUb9VcxguWurA@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-12-git-send-email-dbaryshkov@gmail.com>
 <20141028145850.GU18557@sirena.org.uk>
 <CAAVeFuKgARoMFzf+663iP6cULs93d4WSQS8ESjUb9VcxguWurA@mail.gmail.com>
Message-ID: <CACRpkdY-RDuxGMWe_SD613ovsEoHhxjP1+3T-m_zKQSx=mkFjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 4:03 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Tue, Oct 28, 2014 at 11:58 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Tue, Oct 28, 2014 at 03:02:04AM +0300, Dmitry Eremin-Solenikov wrote:
>>> Since LoCoMo driver has been converted to provide proper gpiolib
>>> interface, make poodle ASoC platform driver use gpiolib API.
>>
>> Please use subject lines matching the style for the subsystem.
>>
>>> +     ret = gpio_request_array(poodle_gpios, ARRAY_SIZE(poodle_gpios));
>>> +     if (ret) {
>>> +             dev_err(&pdev->dev, "gpio_request_array() failed: %d\n",
>>> +                             ret);
>>> +             return ret;
>>> +     }
>>
>> I sense a need for devm_gpio_request_array() here.  Otherwise this looks
>> fine - ideally it'd move to gpiod but moving to gpiolib is a clear win
>> so no need to block on this.
>
> I wish Dmitry took the opportunity to move this driver to the gpiod
> API, especially since doing so would be trivial for this driver.

+1 on this.

However this platform is not device tree, so this implies setting up
a descriptor table for the affected driver(s) to work properly.
See Documentation/gpio/board.txt

Yours,
Linus Walleij
