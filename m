From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 20 Mar 2013 22:28:23 +0800
Subject: [PATCH 1/8] pinctrl: sirf: convert to linear irq domain
In-Reply-To: <1363779679-16880-2-git-send-email-arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <1363779679-16880-2-git-send-email-arnd@arndb.de>
Message-ID: <CAGsJ_4zRhRX+g9Xf6RSPFtXrer+_7-hg2WCsVjAtRpY=q7tqtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2013/3/20 Arnd Bergmann <arnd@arndb.de>:
> The sirf platforms use no hardcoded IRQ numbers, so there is no reason to
> use the legacy domain, and by converting to the linear domain, we get
> a more efficient representation of sparse IRQs and remove the dependency
> on the mach/irqs.h header file.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>

a dependency issue is recently i sent a patch for re-arch sirf
pinctrl, pull the soc-specific pin/group/functionality layout out of
the drivers/pinctrl/pinctrl-sirf.c, and created new seperate
soc-layout files for prima2 and atlas6 in drivers/pinctrl/sirf.
Barry Song:
[PATCH]pinctrl:sirf:re-arch and add support for new SiRFatlas6 SoC
http://www.spinics.net/lists/arm-kernel/msg230700.html
i will merge yours with that.

Hi Linus,
would you give some comments about that sirf re-arch patch, i hope all
of them could be in 3.10.

> ---
>  drivers/pinctrl/pinctrl-sirf.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
> index d02498b..a0bc78b 100644
> --- a/drivers/pinctrl/pinctrl-sirf.c
> +++ b/drivers/pinctrl/pinctrl-sirf.c
> @@ -1485,7 +1485,6 @@ static void sirfsoc_gpio_handle_irq(unsigned int irq, struct irq_desc *desc)

-barry
