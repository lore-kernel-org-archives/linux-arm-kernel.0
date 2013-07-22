From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Jul 2013 00:43:35 +0200
Subject: [PATCH 1/4] pinctrl: Remove duplicate code in
 pinctrl_pm_select_state functions
In-Reply-To: <20130718151504.30990.96819.stgit@localhost>
References: <20130718151213.30990.45828.stgit@localhost>
 <20130718151504.30990.96819.stgit@localhost>
Message-ID: <CACRpkdYbXEPmHwzGMwJ9e-VEJsOumYboGdQcPHqbq87FNL3fBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 5:15 PM, Tony Lindgren <tony@atomide.com> wrote:

> There's no need to duplicate essentially the same functions. Let's
> introduce static int pinctrl_pm_select_state() and make the other
> related functions call that.
>
> This allows us to add support later on for multiple active states,
> and more optimized dynamic remuxing.
>
> Note that we still need to export the various pinctrl_pm_select
> functions as we want to keep struct pinctrl_state private to the
> pinctrl code, and cannot replace those with inline functions.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Aha that is how to do it. Stephen complained about it earlier
but I couldn't come up with a good enough refactoring.

Patch applied.

Yours,
Linus Walleij
