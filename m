From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 22:58:48 +0100
Subject: [PATCH] pinctrl:sirf:re-arch and add support for new SiRFatlas6
 SoC
In-Reply-To: <1363597988-7409-1-git-send-email-Barry.Song@csr.com>
References: <1363597988-7409-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdYUTQ_7V1CbKbx05zgBONj6iUi=ekzSwmZz8dqeRx7ZJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 10:13 AM, Barry Song <Barry.Song@csr.com> wrote:

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

This is OK but can you please:

- Base the patch on the "devel" branch in my pinctrl tree?

- Try to use the -M flag when formatting the patch so it
  gets more readable?

Yours,
Linus Walleij
