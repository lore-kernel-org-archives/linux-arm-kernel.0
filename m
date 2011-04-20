From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 20 Apr 2011 21:38:59 +0900
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <BANLkTimfkpjQ9DoYKRTVwyvtPRccO+RwpA@mail.gmail.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
	<6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
	<20110419093855.36910400@lxorguk.ukuu.org.uk>
	<BANLkTimqpP2k1tBvRL0BXs9E-Q=3bh0C7Q@mail.gmail.com>
	<BANLkTimfkpjQ9DoYKRTVwyvtPRccO+RwpA@mail.gmail.com>
Message-ID: <BANLkTim7pGJVEngS7jJHgcn1FTMEiUC83w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 9:32 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/4/19 Kyungmin Park <kmpark@infradead.org>:
>
>> One more consideration, not mentioned previous time, is that pin
>> configuration for power down mode.
>> Samsung SoCs has retention GPIO configurations at sleep (suspend)
>> mode. and restore it at resume time.
>> it's need to reduce power and proper operation after suspend.
>
> Isn't this supposed to be handled by runtime_pm hooks inside
> your GPIO driver rather than by someone else talking to
> the GPIO driver trying to spool/unspool the state from the
> outside in some other place?

It's different from normal gpio input/output pin. It has different
offset and configuration.
As I know, current gpiolib doesn't support it.

Of course these should be handled at board file instead of drivers.

Thank you,
Kyungmin Park
>
> Or am I getting things backwards now...?
>
> Yours,
> Linus Walleij
>
