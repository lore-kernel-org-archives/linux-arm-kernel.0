From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Nov 2012 09:07:45 +0100
Subject: [PATCH V2 1/5] Revert "pinctrl: remove pinctrl_remove_gpio_range"
In-Reply-To: <d08146fb6ea692330a2b0c6a4fe2df75edc0f20e.1351330569.git.viresh.kumar@linaro.org>
References: <cover.1351330569.git.viresh.kumar@linaro.org>
 <d08146fb6ea692330a2b0c6a4fe2df75edc0f20e.1351330569.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkdY-ygdPOE48Up3pFXgxj9FqU6hk+C8B-TSXiV80UDf3YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2012 at 11:51 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> This reverts earlier commit which removed pinctrl_remove_gpio_range(), because
> at that time there aren't any more users of that routine. It was removed as the
> removal of ranges was done in unregister of pinctrl.
>
> But because we are registering stuff from gpiolib now, we may remove and insert
> a gpio module multiple times. So, we need that again.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as prerequisite for patch 2.

Yours,
Linus Walleij
