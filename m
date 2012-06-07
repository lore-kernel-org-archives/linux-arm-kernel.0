From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Jun 2012 13:06:49 +0200
Subject: [PATCH] pinctrl: sirf: mark of_device_id match table as
 __devinitconst
In-Reply-To: <1337569142-18756-1-git-send-email-Barry.Song@csr.com>
References: <1337569142-18756-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdZcnWO3YL2+hVUpuRh-psZHq61oAOh5sp9A91UJ732hAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 4:59 AM, Barry Song <Barry.Song@csr.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
> ?drivers/pinctrl/pinctrl-sirf.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
> index 6b3534c..5816cc3 100644
> --- a/drivers/pinctrl/pinctrl-sirf.c
> +++ b/drivers/pinctrl/pinctrl-sirf.c
> @@ -1192,7 +1192,7 @@ out_no_gpio_remap:
> ? ? ? ?return ret;
> ?}
>
> -static const struct of_device_id pinmux_ids[] ?= {
> +static const struct of_device_id pinmux_ids[] __devinitconst = {
> ? ? ? ?{ .compatible = "sirf,prima2-gpio-pinmux" },
> ? ? ? ?{}
> ?};

Hm Uwe poked me about this change, Barry are you sure the DT
ID table can be __devinitconst? I would think so, but better check
again.

Yours,
Linus Walleij
