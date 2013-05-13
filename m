From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 May 2013 19:48:48 +0200
Subject: [PATCH 1/3] mmc: mmci: Use optional sleep pinctrl state
In-Reply-To: <1368452837-31458-2-git-send-email-ulf.hansson@stericsson.com>
References: <1368452837-31458-1-git-send-email-ulf.hansson@stericsson.com>
 <1368452837-31458-2-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdarH5FbegyN17n+--hoCgHqzEupUA0pjkXG3juCA9aW5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 3:47 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> By optionally putting the pins into sleep state in the .runtime_suspend
> callback we can accomplish two things. One is to minimize current leakage
> from pins and thus save power, second we can prevent the IP from driving
> pins output in an uncontrolled manner, which may happen if the power domain
> drops the domain regulator.
>
> When returning from idle, entering .runtime_resume callback, the pins
> are restored to default state.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks straight-forward from a pinctrl point of view.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
