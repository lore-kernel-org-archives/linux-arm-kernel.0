From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Fri, 31 Jan 2014 12:30:05 +0000
Subject: [PATCH 2/4] pinctrl: st: add stid127 support
In-Reply-To: <1391093744-19905-3-git-send-email-patrice.chotard@st.com>
References: <1391093744-19905-1-git-send-email-patrice.chotard@st.com>
 <1391093744-19905-3-git-send-email-patrice.chotard@st.com>
Message-ID: <52EB974D.3070403@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks good for me.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>

On 30/01/14 14:55, Patrice CHOTARD wrote:
> From: Alexandre TORGUE <alexandre.torgue@st.com>
> 
> Add STid127 PIOs (psouth, pwest, peast) in pinctrl.
> 
> Signed-off-by: alexandre torgue <alexandre.torgue@st.com>
> ---
>  drivers/pinctrl/pinctrl-st.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> index 9cadc68..01227de 100644
> --- a/drivers/pinctrl/pinctrl-st.c
> +++ b/drivers/pinctrl/pinctrl-st.c
> @@ -336,6 +336,27 @@ static const struct st_pctl_data  stih416_data = {
>  	.alt = 0, .oe = 40, .pu = 50, .od = 60, .rt = 100,
>  };
>  
> +/* STid127 data */
> +static const struct st_pctl_data  stid127_data = {
> +	.rt_style	= st_retime_style_dedicated,
> +	/* reuse stih416 delays as they are identical */
> +	.input_delays	= stih416_delays,
> +	.ninput_delays	= 14,
> +	/* reuse stih416 delays as they are identical */
> +	.output_delays	= stih416_delays,
> +	.noutput_delays = 14,
> +	.alt = 0, .oe = 8, .pu = 10, .od = 12, .rt = 14,
> +};
> +
> +static const struct st_pctl_data  stid127_psouth_data = {
> +	.rt_style	= st_retime_style_dedicated,
> +	.input_delays	= stid127_delays,
> +	.ninput_delays	= 14,
> +	.output_delays	= stid127_delays,
> +	.noutput_delays = 14,
> +	.alt = 0, .oe = 7, .pu = 9, .od = 11, .rt = 13,
> +};
> +
>  /* Low level functions.. */
>  static inline int st_gpio_bank(int gpio)
>  {
> @@ -1264,6 +1285,10 @@ static struct of_device_id st_pctl_of_match[] = {
>  	{ .compatible = "st,stih416-rear-pinctrl", .data = &stih416_data},
>  	{ .compatible = "st,stih416-fvdp-fe-pinctrl", .data = &stih416_data},
>  	{ .compatible = "st,stih416-fvdp-lite-pinctrl", .data = &stih416_data},
> +	{ .compatible = "st,stid127-pwest-pinctrl", .data = &stid127_data },
> +	{ .compatible = "st,stid127-psouth-pinctrl",
> +		.data = &stid127_psouth_data },
> +	{ .compatible = "st,stid127-peast-pinctrl", .data = &stid127_data },
>  	{ /* sentinel */ }
>  };
>  
> 
