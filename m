From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Aug 2014 08:19:13 +0200
Subject: [PATCH 1/4] gpio: syscon: add soc specific callback to assign
 output value
In-Reply-To: <1407946582-20927-2-git-send-email-grygorii.strashko@ti.com>
References: <1407946582-20927-1-git-send-email-grygorii.strashko@ti.com>
 <1407946582-20927-2-git-send-email-grygorii.strashko@ti.com>
Message-ID: <CACRpkdaq2=f92yEEZgGHOtixDk35O9tmN2PZkSPKrGwGVDS_mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 6:16 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> Some SoCs (like Keystone) may require to perform special
> sequence of operations to assign output GPIO value, so default
> implementation of .set() callback from gpio-syscon driver
> can't be used.
>
> Hence, add optional, SoC specific callback to assign output
> gpio value.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Hm :-/

I didn't realize this wasn't a quite so straight-forward a
syscon GPIO driver.

Now I start to think that it looks kludgy to bolt this onto
the other driver and think we may need to go back to the
other version which puts it as a separate driver. I guess
that is what you refer to as v1?

I have a hard time to make my mind up about these
syscon things, sorry :-(

Now I have to ask you: which way do you prefer to do it,
if you can choose freely? The initial driver or augmenting
the syscon driver (patch v1)?

Yours,
Linus Walleij
