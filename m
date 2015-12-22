From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Dec 2015 10:25:06 +0100
Subject: [PATCH 2/3] Add support for monitoring gpio switches
In-Reply-To: <567138E2.80505@collabora.co.uk>
References: <1449250275-23435-1-git-send-email-martyn.welch@collabora.co.uk>
 <1449250275-23435-3-git-send-email-martyn.welch@collabora.co.uk>
 <CACRpkdb=it+U+3-0mvZ9Pf1cnYT_r1KkFiS=C4YDkqrjoRm+kQ@mail.gmail.com>
 <567138E2.80505@collabora.co.uk>
Message-ID: <CACRpkdZWXnR0tUbr9KeX3KPEe11pUYC5ZcBkX8jvUx3fREwHgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 11:11 AM, Martyn Welch
<martyn.welch@collabora.co.uk> wrote:

>> Patches like that has however already been suggested, and I have NACKed
>> them because the GPIO sysfs ABI is insane, and that is why I am
>> refactoring
>> the world to create a proper chardev ABI for GPIO instead. See:
>> http://marc.info/?l=linux-gpio&m=144550276512673&w=2
>
> I can certainly understand the rationale for the changes that you are
> proposing, though do worry that it does make it a bit tougher to use from
> scripting languages.

The idea is to provide commandline tools in the kernel tools/gpio subdir
to satisfy the needs of scripting. "lsgpio" today is just one example,
nothing stops us from having a tool called just "gpio-sak"
(GPIO swiss army knife) that will be tailored for scripting.

> I see that the question of how to provide functionality
> equivalent to the above was raised and no answer was forthcoming. Is there a
> plan for supporting the identification of a GPIO line serving a specific
> purpose?

Yes by name.

> What is the status of the mentioned patch series?

They stubled into a few dozen architecture issues in the GPIO
subsystem so I am busy refactoring the whole know universe :D

But I still intend to persue the series.

Yours,
Linus Walleij
