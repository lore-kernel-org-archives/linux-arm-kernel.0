From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 15:36:20 +0200
Subject: [PATCH RESEND] pinctrl:sirf:re-arch and add support for new
 SiRFatlas6 SoC
In-Reply-To: <1368513446-22712-1-git-send-email-Baohua.Song@csr.com>
References: <1368513446-22712-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <CACRpkdZ72JqJXGnvdE31Bb4H91pHjvXA_FRKes2Fz1z4Qoo8iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 8:37 AM, Barry Song <Baohua.Song@csr.com> wrote:

> atlas6 is a SoC very similar with primaII, the register layput of
> pinctrl is same, but the pads, groups and functions of atlas6 have
> different layout with prima2, this patch
> 1. pull the definition of pads, groups and functions out of the
> pinctrl-sirf driver,and put them into soc-specific files
> 2. add pads, groups and functions tables for atlas6
> 3. let pads, groups and functions tables become the config data of
>    the related dt compatible node, so the pinctrl-sirf can support
>    all SiRF SoCs with the config data as private data.
>
> In this patch,we create a sirf dir, and let
> the old drivers/pinctrl/pinctrl-sirf.c =
>         drivers/pinctrl/sirf/pinctrl-prima2.c +
>         drivers/pinctrl/sirf/pinctrl-sirf.c
>
> drivers/pinctrl/sirf/pinctrl-atlas6.c is a newly created file for the
> pin layout of atlas6.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

This doesn't apply. Alas I have applied some cleanups to the Sirf
driver before this patch, but not *that* many changes... can you
rebase to the pinctrl "devel" branch?

Yours,
Linus Walleij
