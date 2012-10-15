From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Oct 2012 22:36:32 +0200
Subject: [PATCH] gpio: clps711x: localise <mach/gpio.h> header
In-Reply-To: <20121016000405.94f779c6066ded6289e35baa@mail.ru>
References: <1350330020-23240-1-git-send-email-linus.walleij@linaro.org>
 <20121016000405.94f779c6066ded6289e35baa@mail.ru>
Message-ID: <CACRpkdYxQsS4RfCxk3E4GPa+7GK2FeOVfTCps1ZtPC=gSw2a0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 10:04 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> On Mon, 15 Oct 2012 21:40:20 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> The commit adding the CLPS711x driver also added <mach/gpio.h>
>> to the CLPS711x, and we want to get rid of all <mach/*>
>> headers for the future. It turns out that the one macro defined
>> in the file was only used in the GPIO driver itself, so just
>> delete it and copy the macro into the driver.
> ...
>> -/* Simple helper for convert port & pin to GPIO number */
>> -#define CLPS711X_GPIO(port, bit)     ((port) * 8 + (bit))
>
> This macro is not used by driver and was be designed especially for future
> easy modify existing drivers that use GPIO to gpio-driver.

Then I will delete it for now (see separate patch).

If we shall have a file with macros used like that it needs
to atleast be something like
<linux/platform_data/gpio-clps711x.h>

We don't want to add new files to <mach/*>.

Yours,
Linus Walleij
