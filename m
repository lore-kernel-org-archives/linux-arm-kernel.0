From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Jun 2014 17:13:45 -0500
Subject: [PATCH] ARM: mvebu: Fix broken SoC ID detection
In-Reply-To: <1402347165-19988-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1402347165-19988-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <CAL_JsqLwZV2TNuTz_ZacwD9iZVL6Weg1wsDoSofg86k6qAZnNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 9, 2014 at 3:52 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> Currently the mvebu boards need to detect the SoC revision in order to apply
> some quirks needed to workaround issues found on I2C and thermal controllers
> present only in very early SoC.
>
> This detection requires PCI address translation to work, so we need to
> explicitly select OF_ADDRESS_PCI.
>
> This can be considered a partial revert of the following commit, that
> wrongly removed the option selection:
>
> commit 55400f3a1f89e39761f45c19f6e4235a329c400b
> Author: Rob Herring <robh@kernel.org>
> Date:   Tue Apr 22 14:15:52 2014 -0500
>
>     ARM: mvebu: clean-up unneeded kconfig selects
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Thanks for fixing it.

Acked-by: Rob Herring <robh@kernel.org>

Rob
