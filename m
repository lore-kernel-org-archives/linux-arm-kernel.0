From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Jun 2013 21:31:22 +0200
Subject: [RFC] ARM: OMAP2+: omap_device: add pinctrl handling
In-Reply-To: <51CAEA90.90200@ti.com>
References: <1371826990-25820-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdY=m1b9Lh27+wHP8FQ4SbVZKmAOCGhxe59aP+TcuR9QaA@mail.gmail.com>
 <20130625065811.GZ5523@atomide.com> <51CAEA90.90200@ti.com>
Message-ID: <CACRpkdbKgEcfF67oO9HrczvDp4Po3Xt1hFajJ1vO8kEvsZH4jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 3:20 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> The "Sleep" pinctrl state is optional - if "sleep" state isn't defined
> then "Idle" pinctrl state will be used during suspend.

Why? If we have a clear cut semantic that "idle" is for runtime
suspend, why should it be a fallback for suspend?

You do realize that can just be turned around (as common suspend
is more widely implemented than runtime suspend) so that we
could say that if "idle" does not exist, we go to "sleep" in
runtime suspend.

> So, final list of default pnctrl states may be defined as "default",
> "active", "idle", "sleep", "off":
> - "active", "idle", "sleep": will be handled by omap_device core
> - "default", "off": will be handled by driver itself (or Device core).

Currently the pinctrl system combines what is called "default"
and "active" into one, assuming that all devices shall come up
in the active state.

Also we haven't seen a device that need some "off" state that
is different from "sleep".

If you want to drive this state list home you have to give a
*real world example*.

I want to see a *real* example, for a device and it's pins,
that define totally different things for these states, as a
rationale.

Else we are just defining states to make nice figures or mental
maps and that is not helpful for drivers writers.

Yours,
Linus Walleij
