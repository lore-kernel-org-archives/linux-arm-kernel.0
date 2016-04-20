From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2016 16:43:24 +0200
Subject: [PATCH 6/8] mfd: Add STMPE1600 support
In-Reply-To: <1461068317-28016-7-git-send-email-patrice.chotard@st.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
 <1461068317-28016-7-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdb73QAs5jZpTq1Qz_RX=fSj3ymQ54S-6RwNDTZ9x8ASkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 2:18 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> STMPE1600 is a 16-bit port expander.
> Datasheet is available here :
> http://www2.st.com/content/st_com/en/products/interfaces-and-transceivers/
> i-o-expanders-and-level-translators/i-o-expanders/stmpe1600.html
>
> As STMPE1600's SYS_CTRL register has the same layout as
> STMPE801 variant, unify STMPExxx_REG_SYS_CTRL_RESET/INT_EN/INT_HI
> bit masks to more generic STMPE_SYS_CTRL_RESET/INT_EN/INT_HI
>
> Signed-off-by: Amelie DELAUNAY <amelie.delaunay@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

(...)
>  #define STMPE_SYS_CTRL_RESET   (1 << 7)
> +#define STMPE_SYS_CTRL_INT_EN  (1 << 2)
> +#define STMPE_SYS_CTRL_INT_HI  (1 << 0)
>
>  /*
>   * STMPE801
> @@ -121,10 +123,6 @@ int stmpe_remove(struct stmpe *stmpe);
>  #define STMPE801_REG_GPIO_SET_PIN      0x11
>  #define STMPE801_REG_GPIO_DIR          0x12
>
> -#define STMPE801_REG_SYS_CTRL_RESET    (1 << 7)
> -#define STMPE801_REG_SYS_CTRL_INT_EN   (1 << 2)
> -#define STMPE801_REG_SYS_CTRL_INT_HI   (1 << 0)

This looks like unrelated cleanups?
Should this be in the reset enablement patch?
(It's OK with me though.)

With that fixed:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
