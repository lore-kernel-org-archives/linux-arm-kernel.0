From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Jul 2013 01:07:57 +0200
Subject: [PATCH 3/4] pinctrl: Add support for additional dynamic states
In-Reply-To: <20130716090536.5541.36289.stgit@localhost>
References: <20130716090310.5541.36777.stgit@localhost>
 <20130716090536.5541.36289.stgit@localhost>
Message-ID: <CACRpkdY6-f1DKfPDfCpYAX9weXMtB7koJ3VwkRgHGm_MzgFawQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 11:05 AM, Tony Lindgren <tony@atomide.com> wrote:

> To toggle dynamic states, let's add the optional active state in
> addition to the static default state. Then if the optional active
> state is defined, we can require that idle and sleep states cover
> the same pingroups as the active state.

OK...

> Then let's add pinctrl_check_dynamic() and pinctrl_select_dynamic()
> to use instead of pinctrl_select() to avoid breaking existing users.
>
> With pinctrl_check_dynamic() we can check that idle and sleep states
> match the active state for pingroups during init, and don't need to
> do it during runtime.

I do not understand why this complexity need to be exposed outside
of the subsystem.

pinctrl_select_state() and the PM accessors are enough IMO. Why
should say a driver care about whether it is dynamic or not?

Surely the checking and different paths for static/dynamic configurations
can be an intrinsic detail of the pinctrl subsystem, by adding flags and
members to private structs like struct pinctrl itself in worst case.

So I'm not buying into this, it looks like it is making things complicated
for consumers outside the subsystem for no reason.

Yours,
Linus Walleij
