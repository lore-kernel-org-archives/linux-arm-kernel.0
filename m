From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Oct 2012 11:16:23 +0200
Subject: [PATCH 03/10] Input: bu21013_ts - Request a regulator that
 actually exists
In-Reply-To: <1349165603-24401-4-git-send-email-lee.jones@linaro.org>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
 <1349165603-24401-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdatjOMxS_pQNPQjoNXgSTYhh7iQoxhKGzdTL=bdQMtwvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2012 at 10:13 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Currently the BU21013 Touch Screen driver requests a regulator by the
> name of 'V-TOUCH', which doesn't exist anywhere in the kernel. The
> correct name, as referenced in platform regulator code is 'avdd'. Here,
> when we request a regulator, we use the correct name instead.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Mark Brown requested this (real) name of the regulator a while back.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This should go separately into the -rc fixes or directly upstream.

Yours,
Linus Walleij
