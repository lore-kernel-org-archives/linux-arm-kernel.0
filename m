From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Jun 2016 18:10:25 +0200
Subject: [PATCH V2 15/63] clocksource/drivers/clksrc-dbx500: Convert init
 function to return error
In-Reply-To: <1466112442-31105-16-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-16-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CACRpkdam56Vnb2dnp_v9OsvakTO=EWq-v+Fb646nJaUTZPNeHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 11:26 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> The init functions do not return any error. They behave as the following:
>
>   - panic, thus leading to a kernel crash while another timer may work and
>        make the system boot up correctly
>
>   or
>
>   - print an error and let the caller unaware if the state of the system
>
> Change that by converting the init functions to return an error conforming
> to the CLOCKSOURCE_OF_RET prototype.
>
> Proper error handling (rollback, errno value) will be changed later case
> by case, thus this change just return back an error or success in the init
> function.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
