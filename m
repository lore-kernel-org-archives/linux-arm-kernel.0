From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Feb 2018 15:01:30 +0100
Subject: [PATCH v3 7/7] watchdog: coh901327: make use of timeout-secs
 provided in devicetree
In-Reply-To: <20180211200847.25000-7-marcus.folkesson@gmail.com>
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
 <20180211200847.25000-7-marcus.folkesson@gmail.com>
Message-ID: <CACRpkdZzw+3DPvS7VOUzghmSgDTgDeCZ2i+FE=DCE+R5i1qycQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 11, 2018 at 9:08 PM, Marcus Folkesson
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
> Notes:
>     v3:
>         - Reformat and use coh901327_wdt.timeout instead of margin when print out
>           timout in probe function.
>
>     v2:
>         - Set .timeout in coh901327_wdt structure declaration.
>         - Set .min_timeout to 1 instead of 0. I could not find a datasheet
>           for coh901327, so I'm not sure if 0 is valid. However, 0 seems
>           wrong to me and most driver has 1 as min value. If it should
>           be 0, please let me know and I have to set another initial
>           value for margin.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
