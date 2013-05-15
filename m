From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 13:27:25 +0200
Subject: [PATCH v2] pinctrl:sirf:re-arch and add support for new
 SiRFatlas6 SoC
In-Reply-To: <1368541078-6002-1-git-send-email-Baohua.Song@csr.com>
References: <1368541078-6002-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <CACRpkdZS36n=4fCjnSmo5UFKgMExA=iUt6565M1ZvM0Qym5XGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 4:17 PM, Barry Song <21cnbao@gmail.com> wrote:

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
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  -v2:
>  rebase to pinctrl/devel

Applied!

Thanks,
Linus Walleij
