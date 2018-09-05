From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 5 Sep 2018 17:00:58 +0200
Subject: [PATCH/RFT] pinctrl: sh-pfc: r8a77995: Add MSIOF pins,
 groups and functions
In-Reply-To: <1536092497-5896-1-git-send-email-ykaneko0929@gmail.com>
References: <1536092497-5896-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <CAMuHMdU+8dn0N-3=wvdFs7gU5iREri3fpZxKuzz3gGa4vDeK_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kaneko-san,

On Tue, Sep 4, 2018 at 10:22 PM Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds MSIOF{0,1,2,3} pins, groups and functions to R8A77995 SoC.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Thanks for your patch!

> This patch is based on the devel branch of Simon Horman's renesas tree.

Which is the wrong tree. According to MAINTAINERS:

    git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
sh-pfc

> --- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c

> @@ -1277,6 +1281,289 @@ enum {

> +/* - MSIOF1 ----------------------------------------------------------------- */
> +static const unsigned int msiof1_clk_pins[] = {
> +       /* SCK */
> +       RCAR_GP_PIN(4, 16),
> +};
> +
> +static const unsigned int msiof1_clk_mux[] = {
> +       MSIOF1_SCK_MARK,
> +};
> +
> +static const unsigned int msiof1_sync_pins[] = {
> +       /* SYNC */
> +       RCAR_GP_PIN(4, 19),
> +};

msiof1_ss2_mux[] should be here.

> +
> +static const unsigned int msiof1_ss1_pins[] = {
> +       /* SS1 */
> +       RCAR_GP_PIN(4, 25),
> +};
> +
> +static const unsigned int msiof1_ss1_mux[] = {
> +       MSIOF1_SS1_MARK,
> +};
> +
> +static const unsigned int msiof1_ss2_pins[] = {
> +       /* SS2 */
> +       RCAR_GP_PIN(4, 22),
> +};
> +
> +static const unsigned int msiof1_ss2_mux[] = {
> +       MSIOF1_SS2_MARK,
> +};
> +
> +static const unsigned int msiof1_sync_mux[] = {
> +       MSIOF1_SYNC_MARK,
> +};
> +
> +static const unsigned int msiof1_txd_pins[] = {
> +       /* TXD */
> +       RCAR_GP_PIN(4, 17),
> +};
> +
> +static const unsigned int msiof1_txd_mux[] = {
> +       MSIOF1_TXD_MARK,
> +};
> +
> +static const unsigned int msiof1_rxd_pins[] = {
> +       /* RXD */
> +       RCAR_GP_PIN(4, 18),
> +};
> +
> +static const unsigned int msiof1_rxd_mux[] = {
> +       MSIOF1_RXD_MARK,
> +};
> +
> +/* - MSIOF2 ----------------------------------------------------------------- */
> +static const unsigned int msiof2_clk_pins[] = {
> +       /* SCK */
> +       RCAR_GP_PIN(0, 3),
> +};
> +
> +static const unsigned int msiof2_clk_mux[] = {
> +       MSIOF2_SCK_MARK,
> +};
> +
> +static const unsigned int msiof2_sync_a_pins[] = {
> +       /* SYNC */
> +       RCAR_GP_PIN(0, 6),
> +};
> +
> +static const unsigned int msiof2_sync_a_mux[] = {
> +       MSIOF2_SYNC_A_MARK,
> +};

I would move the msiof2_sync_b definition here.

> +
> +static const unsigned int msiof2_ss1_pins[] = {
> +       /* SS1 */
> +       RCAR_GP_PIN(0, 7),
> +};
> +
> +static const unsigned int msiof2_ss1_mux[] = {
> +       MSIOF2_SS1_MARK,
> +};
> +
> +static const unsigned int msiof2_ss2_pins[] = {
> +       /* SS2 */
> +       RCAR_GP_PIN(0, 8),
> +};
> +
> +static const unsigned int msiof2_ss2_mux[] = {
> +       MSIOF2_SS2_MARK,
> +};
> +
> +static const unsigned int msiof2_sync_b_pins[] = {
> +       /* SYNC */
> +       RCAR_GP_PIN(0, 2),
> +};
> +
> +static const unsigned int msiof2_sync_b_mux[] = {
> +       MSIOF2_SYNC_B_MARK,
> +};
> +
> +static const unsigned int msiof2_txd_pins[] = {
> +       /* TXD */
> +       RCAR_GP_PIN(0, 4),
> +};
> +
> +static const unsigned int msiof2_txd_mux[] = {
> +       MSIOF2_TXD_MARK,
> +};
> +
> +static const unsigned int msiof2_rxd_pins[] = {
> +       /* RXD */
> +       RCAR_GP_PIN(0, 5),
> +};
> +
> +static const unsigned int msiof2_rxd_mux[] = {
> +       MSIOF2_RXD_MARK,
> +};

> @@ -1752,6 +2039,37 @@ enum {
>         SH_PFC_PIN_GROUP(mmc_data4),
>         SH_PFC_PIN_GROUP(mmc_data8),
>         SH_PFC_PIN_GROUP(mmc_ctrl),
> +       SH_PFC_PIN_GROUP(msiof0_clk),
> +       SH_PFC_PIN_GROUP(msiof0_sync),
> +       SH_PFC_PIN_GROUP(msiof0_ss1),
> +       SH_PFC_PIN_GROUP(msiof0_ss2),
> +       SH_PFC_PIN_GROUP(msiof0_rxd),
> +       SH_PFC_PIN_GROUP(msiof0_txd),

Please use the same order as the msiof*_pins[] arrays above.

> +       SH_PFC_PIN_GROUP(msiof1_clk),
> +       SH_PFC_PIN_GROUP(msiof1_sync),
> +       SH_PFC_PIN_GROUP(msiof1_ss1),
> +       SH_PFC_PIN_GROUP(msiof1_ss2),
> +       SH_PFC_PIN_GROUP(msiof1_rxd),
> +       SH_PFC_PIN_GROUP(msiof1_txd),

Likewise.

> +       SH_PFC_PIN_GROUP(msiof2_clk),
> +       SH_PFC_PIN_GROUP(msiof2_sync_a),
> +       SH_PFC_PIN_GROUP(msiof2_ss1),
> +       SH_PFC_PIN_GROUP(msiof2_ss2),
> +       SH_PFC_PIN_GROUP(msiof2_sync_b),
> +       SH_PFC_PIN_GROUP(msiof2_rxd),
> +       SH_PFC_PIN_GROUP(msiof2_txd),

Likewise.

> +       SH_PFC_PIN_GROUP(msiof3_clk_a),
> +       SH_PFC_PIN_GROUP(msiof3_sync_a),
> +       SH_PFC_PIN_GROUP(msiof3_ss1_a),
> +       SH_PFC_PIN_GROUP(msiof3_ss2_a),
> +       SH_PFC_PIN_GROUP(msiof3_txd_a),
> +       SH_PFC_PIN_GROUP(msiof3_rxd_a),
> +       SH_PFC_PIN_GROUP(msiof3_clk_b),
> +       SH_PFC_PIN_GROUP(msiof3_sync_b),
> +       SH_PFC_PIN_GROUP(msiof3_ss1_b),
> +       SH_PFC_PIN_GROUP(msiof3_ss2_b),
> +       SH_PFC_PIN_GROUP(msiof3_rxd_b),
> +       SH_PFC_PIN_GROUP(msiof3_txd_b),

Likewise.

>         SH_PFC_PIN_GROUP(pwm0_a),
>         SH_PFC_PIN_GROUP(pwm0_b),
>         SH_PFC_PIN_GROUP(pwm0_c),
> @@ -1982,6 +2300,49 @@ enum {
>         "vin4_clk",
>  };
>
> +static const char * const msiof0_groups[] = {
> +       "msiof0_clk",
> +       "msiof0_sync",
> +       "msiof0_ss1",
> +       "msiof0_ss2",
> +       "msiof0_rxd",
> +       "msiof0_txd",

Please use the same order as the msiof*_pins[] arrays above.

> +};
> +
> +static const char * const msiof1_groups[] = {
> +       "msiof1_clk",
> +       "msiof1_sync",
> +       "msiof1_ss1",
> +       "msiof1_ss2",
> +       "msiof1_rxd",
> +       "msiof1_txd",

Likewise.

> +};
> +
> +static const char * const msiof2_groups[] = {
> +       "msiof2_clk",
> +       "msiof2_sync_a",
> +       "msiof2_ss1",
> +       "msiof2_ss2",
> +       "msiof2_sync_b",
> +       "msiof2_rxd",
> +       "msiof2_txd",

Likewise.

> +};
> +
> +static const char * const msiof3_groups[] = {
> +       "msiof3_clk_a",
> +       "msiof3_sync_a",
> +       "msiof3_ss1_a",
> +       "msiof3_ss2_a",
> +       "msiof3_txd_a",
> +       "msiof3_rxd_a",
> +       "msiof3_clk_b",
> +       "msiof3_sync_b",
> +       "msiof3_ss1_b",
> +       "msiof3_ss2_b",
> +       "msiof3_rxd_b",
> +       "msiof3_txd_b",

Likewise.

> +};

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
