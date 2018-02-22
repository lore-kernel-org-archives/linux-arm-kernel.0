From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Feb 2018 15:00:47 +0100
Subject: [PATCH v2 7/7] watchdog: coh901327: make use of timeout-secs
 provided in devicetree
In-Reply-To: <20180210091911.3644-7-marcus.folkesson@gmail.com>
References: <20180210091911.3644-1-marcus.folkesson@gmail.com>
 <20180210091911.3644-7-marcus.folkesson@gmail.com>
Message-ID: <CACRpkdbhm5s8tcF8vBeDVdzFbgo-L_BJk=76Qv=m5WNBdSbRhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 10, 2018 at 10:19 AM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:

> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
>
> Following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt to make use of
> the parameter logic.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>
> v2:
>         - Set .timeout in coh901327_wdt structure declaration.
>         - Set .min_timeout to 1 instead of 0. I could not find a datasheet
>           for coh901327, so I'm not sure if 0 is valid. However, 0 seems
>                   wrong to me and most driver has 1 as min value. If it should
>                   be 0, please let me know and I have to set another initial
>                   value for margin.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
