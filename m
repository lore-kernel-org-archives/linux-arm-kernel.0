From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jul 2014 17:47:50 +0200
Subject: [PATCH] pinctrl: pinctrl-at91.c: Cleaning up values that are
 never used
In-Reply-To: <1403790091-11423-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1403790091-11423-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <CACRpkdbHGSY4tiRy0pOmRKdLMQx3nOvGwF7mE-8G24-8b7LN8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 3:41 PM, Rickard Strandqvist
<rickard_strandqvist@spectrumdigital.se> wrote:

> Remove variable that are never used
>
> This was found using a static code analysis program called cppcheck.
>
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
(...)
> -       int ret, val, num_conf = 0;
> +       int val, num_conf = 0;
>
> -       ret = at91_pinconf_get(pctldev, pin_id, &config);
> +       at91_pinconf_get(pctldev, pin_id, &config);

Hm I would have preferred a fix actually checking the ret value,
but the debug show doesn't allow failing, and it's just for
debug anyway...

Patch applied.

Yours,
Linus Walleij
