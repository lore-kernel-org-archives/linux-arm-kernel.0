From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 7 May 2012 21:21:31 +0530
Subject: [PATCH] gpiolib: Add of_get_gpio_chip_by_phandle() helper
In-Reply-To: <CACRpkda2jBmjPCgt=5rfqdCQH9Lipq4aejeQq-Qbw0_Nk6o-yg@mail.gmail.com>
References: <cdf5352edf6b32e2505e1c7ba9997613150094c1.1335949228.git.viresh.kumar@st.com>
 <4FA15267.4090306@wwwdotorg.org>
 <CAOh2x=nrNDrtNjOroWOm6HkYkc3f2qfaWrtN97d1M3rWv1qmsQ@mail.gmail.com>
 <CACRpkda2jBmjPCgt=5rfqdCQH9Lipq4aejeQq-Qbw0_Nk6o-yg@mail.gmail.com>
Message-ID: <CAOh2x=nizQYXWFu3deQPXr93Nqv77Pnj5DNhYZw_vYyY2go3vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2012 at 6:38 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, May 2, 2012 at 6:51 PM, viresh kumar <viresh.linux@gmail.com> wrote:
>
>> So i need someway of accessing gpio chip
>> from pinctrl driver. How should i do it?
>
> I once proposed a patch like this to gpiolib and Grant NACK:ed it.
> It was one of the reasons I created pinctrl to begin with...

@Grant/Linus: Any specific reason, why it got rejected?

I don't feel there is anything wrong in this approach and is a very
clean solution to
bind two drivers.

> The U300 solution isn't super-clean, and I have another
> solution for Nomadik which is cleaner, but there GPIO and
> pinctrl is in the same file. Expect to mail that out tomorrow.

Even that is not so clean. You are creating another mess in order to fix one.
Two drivers implementing separate functionality must be kept separate.

--
viresh
