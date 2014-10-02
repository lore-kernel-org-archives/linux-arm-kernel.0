From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 2 Oct 2014 10:28:44 +0200
Subject: [PATCH] cpufreq: integrator: fix integrator_cpufreq_remove return
 type
In-Reply-To: <1845195.odREGsY0qB@wuerfel>
References: <1845195.odREGsY0qB@wuerfel>
Message-ID: <CACRpkdZXWNs8-y_13tmKerjfROdjd-EaXi6i3TSK2xPH-_rz7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 10:19 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> When building this driver as a module, we get a helpful warning
> about the return type:
>
> drivers/cpufreq/integrator-cpufreq.c:232:2: warning: initialization from incompatible pointer type
>   .remove = __exit_p(integrator_cpufreq_remove),
>
> If the remove callback returns void, the caller gets an undefined
> value as it expects an integer to be returned. This fixes the
> problem by passing down the value from cpufreq_unregister_driver.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
