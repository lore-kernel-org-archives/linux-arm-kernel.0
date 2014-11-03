From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 3 Nov 2014 20:12:47 +0100
Subject: [PATCH 3/7] pinctrl: pinconf-generic: Allow driver to specify DT
 params
In-Reply-To: <1415041531-15520-4-git-send-email-soren.brinkmann@xilinx.com>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-4-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CAMuHMdVZQQXx75-0GWCFNnFqEH8S+b0TcWWUGCqgmyzNkyRtYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 3, 2014 at 8:05 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> --- a/include/linux/pinctrl/pinctrl.h
> +++ b/include/linux/pinctrl/pinctrl.h

> @@ -117,6 +118,8 @@ struct pinctrl_ops {
>   * @confops: pin config operations vtable, if you support pin configuration in
>   *     your driver
>   * @owner: module providing the pin controller, used for refcounting
> + * @num_dt_params: Number of driver-specifid DT parameters

driver-specific

> + * @params: List of DT parameters

Missing @conf_items documentation.

>   */
>  struct pinctrl_desc {
>         const char *name;
> @@ -126,6 +129,11 @@ struct pinctrl_desc {
>         const struct pinmux_ops *pmxops;
>         const struct pinconf_ops *confops;
>         struct module *owner;
> +#if defined(CONFIG_GENERIC_PINCONF) && defined(CONFIG_OF)
> +       unsigned int num_dt_params;
> +       const struct pinconf_generic_dt_params *params;
> +       const struct pin_config_item *conf_items;
> +#endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
