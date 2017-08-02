From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 2 Aug 2017 11:06:27 +0800
Subject: [linux-sunxi] [PATCH v3 06/12] ASoC: sun4i-i2s: Add changes for
 wss and sr
In-Reply-To: <20170729141753.20174-7-codekipper@gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
 <20170729141753.20174-7-codekipper@gmail.com>
Message-ID: <CAGb2v66n4QvRM7VjcHgDeEtgXGnnweH6DOyrm1B_VTXMLO_4aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 29, 2017 at 10:17 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On newer SoCs the location of the slot width select and sample
> resolution are different and also there is a bigger range of
> support.
>
> For the current supported rates then an offset is required.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 120f797a38e8..171df99a267e 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -98,6 +98,9 @@
>   * @sun4i_i2s_regmap: regmap config to use.
>   * @mclk_offset: Value by which mclkdiv needs to be adjusted.
>   * @bclk_offset: Value by which bclkdiv needs to be adjusted.
> + * @fmt_offset: Value by which wss and sr needs to be adjusted.
> + * @field_fmt_set_wss: regmap field to set word select size.
> + * @field_fmt_set_sr: regmap field to set sample resolution.

One more thing. Is "_set_" necessary? "field_fmt_wss" seems fine
and makes plenty of sense to me.

ChenYu
