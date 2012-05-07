From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 May 2012 15:08:31 +0200
Subject: [PATCH] gpiolib: Add of_get_gpio_chip_by_phandle() helper
In-Reply-To: <CAOh2x=nrNDrtNjOroWOm6HkYkc3f2qfaWrtN97d1M3rWv1qmsQ@mail.gmail.com>
References: <cdf5352edf6b32e2505e1c7ba9997613150094c1.1335949228.git.viresh.kumar@st.com>
 <4FA15267.4090306@wwwdotorg.org>
 <CAOh2x=nrNDrtNjOroWOm6HkYkc3f2qfaWrtN97d1M3rWv1qmsQ@mail.gmail.com>
Message-ID: <CACRpkda2jBmjPCgt=5rfqdCQH9Lipq4aejeQq-Qbw0_Nk6o-yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2012 at 6:51 PM, viresh kumar <viresh.linux@gmail.com> wrote:

> So i need someway of accessing gpio chip
> from pinctrl driver. How should i do it?

I once proposed a patch like this to gpiolib and Grant NACK:ed it.
It was one of the reasons I created pinctrl to begin with...

Yes, I know it is sometimes a trouble to get the struct gpio_chip *
pointer out, especially if the drivers for pinctrl and GPIO is in
different files with their own say platform_device probe() function
or so.

The U300 solution isn't super-clean, and I have another
solution for Nomadik which is cleaner, but there GPIO and
pinctrl is in the same file. Expect to mail that out tomorrow.

Yours,
Linus Walleij
