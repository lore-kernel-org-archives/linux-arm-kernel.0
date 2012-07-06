From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Jul 2012 08:55:49 +0200
Subject: [PATCH 3/9] ARM: ux500: Remove AB8500 regulator register
 initialisation information
In-Reply-To: <1341493572-29735-4-git-send-email-lee.jones@linaro.org>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <1341493572-29735-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbRtFX8_++rndCpsH7R1uhwPrkTE_GKgNTM6r1PSuwY0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 5, 2012 at 3:06 PM, Lee Jones <lee.jones@linaro.org> wrote:

> There is no need to initialise the AB8500's regulator registers, as
> most of this work is already carried out by framework features, so
> we can safely remove all traces from platform code.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

NACK, sorry.

These registers are used to set up sleep states for the regulators,
e.g that some regulators will turn off when the system go to sleep.

If you delete this code it's no longer possible to make the system
powerefficient, power consumption increases so it causes a
regression.

The proper thing to do is to take the AB8500 datasheet, go in and
read what these registers actually do, and provide the same
features through the framework, if just poking the registers
is deemed non-elegant (I see the point in that).

This is the AB8500 datasheet:
http://www.stericsson.com/developers/CD00291561_UM1031_AB8500_user_manual-rev5_CTDS_public.pdf

So please refactor this, don't just delete, that's destroying a lot
of useful stuff.

Yours,
Linus Walleij
