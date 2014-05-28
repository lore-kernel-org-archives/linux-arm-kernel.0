From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 May 2014 11:07:33 +0200
Subject: [PATCH v2 1/1] ARM: ux500: Staticize ux500_soc_attr
In-Reply-To: <1401247907-8366-1-git-send-email-sachin.kamat@linaro.org>
References: <1401247907-8366-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CACRpkdYx+-vNS_fbW=2XD8iX9TGo9V+L5prcokmNpq57DNebBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 5:31 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:

> 'ux500_soc_attr' is local to this file. While at it also make it
> const to match the argument list of device_create_file.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> Made ux500_soc_attr const as suggested by Lee Jones.
(...)
> -struct device_attribute ux500_soc_attr =
> +static const struct device_attribute ux500_soc_attr =
>         __ATTR(process,  S_IRUGO, ux500_get_process,  NULL);

I alrerady have queued a patch from Thierry Reding switching this
to static.
http://marc.info/?l=linux-arm-kernel&m=139642578413650&w=2

However that patch does not switch it to const.

I'll just augment Thierry's patch to do that too, this is too much
fuzz to have a separate patch for constifying.

Yours,
Linus Walleij
