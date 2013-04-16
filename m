From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Apr 2013 14:34:39 +0200
Subject: [V3 patch 05/19] ARM: ux500: cpuidle: replace for_each_online_cpu
 by for_each_possible_cpu
In-Reply-To: <1365770165-27096-6-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-6-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CACRpkdasndAyCitHkB3z3vH06WOD7qtzzjD9cXmAkvUEO_x3OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 2:35 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> All the drivers are using, in their initialization function, the
> for_each_possible_cpu macro.
>
> Using for_each_online_cpu means the driver must handle the initialization
> of the cpuidle device when a cpu is up which is not the case here.
>
> Change the macro to for_each_possible_cpu as that fix the hotplug
> initialization and make the initialization routine consistent with the
> rest of the code in the different drivers.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
