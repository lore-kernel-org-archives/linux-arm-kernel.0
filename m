From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 20 Jun 2018 03:45:01 +0300
Subject: [PATCH 2/5] RFC: eeprom: at24: Allow passing gpiodesc from pdata
In-Reply-To: <20180618074556.6944-3-linus.walleij@linaro.org>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
 <20180618074556.6944-3-linus.walleij@linaro.org>
Message-ID: <CAHp75Vd8VeYh8KOvCW54u-ZnP3jM60aCD9AnWxKYsSBSX09Y4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 10:45 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This makes it possible to pass an initialized GPIO descriptor
> to the driver through platform data.
>
> This is useful when we are dealing with EEPROMs on expansion
> boards where the GPIO has to be looked up indirectly using a
> connector abstraction (several systems using the same
> connector) so the machine descriptor tables cannot be used
> to associate the descriptor with the device and we then want
> to pass this descriptor on to the EEPROM driver this way
> instead.

How this descriptor is supposed to be created?
Whenever we probe the device we might add properties to it (consider
how MFD does instansiate them), I guess same way GPIO lookup tables
work. No?

P.S. I really would like to hear a _strong_ argument why it can't be
done using other means like built-in device properties or GPIO lookup
tables (which on my opinion have to work in the similar way at run
time).

-- 
With Best Regards,
Andy Shevchenko
