From: patrice.chotard@st.com (Patrice Chotard)
Date: Fri, 27 Jun 2014 08:47:04 +0200
Subject: [PATCH] pinctrl: pinctrl-st.c: Cleaning up values that are never
 used
In-Reply-To: <1403790272-11635-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1403790272-11635-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <53AD1368.8020305@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rickard

On 06/26/2014 03:44 PM, Rickard Strandqvist wrote:
> Remove variable that are never used
>
> This was found using a static code analysis program called cppcheck.
>
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>   drivers/pinctrl/pinctrl-st.c |    6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> index 1bd6363bc9..d3bd687 100644
> --- a/drivers/pinctrl/pinctrl-st.c
> +++ b/drivers/pinctrl/pinctrl-st.c
> @@ -1178,9 +1178,7 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
>   	const __be32 *list;
>   	struct property *pp;
>   	struct st_pinconf *conf;
> -	phandle phandle;
>   	struct device_node *pins;
> -	u32 pin;
>   	int i = 0, npins = 0, nr_props;
>   
>   	pins = of_get_child_by_name(np, "st,pins");
> @@ -1218,8 +1216,8 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
>   		conf = &grp->pin_conf[i];
>   
>   		/* bank & offset */
> -		phandle = be32_to_cpup(list++);
> -		pin = be32_to_cpup(list++);
> +		be32_to_cpup(list++);
> +		be32_to_cpup(list++);
>   		conf->pin = of_get_named_gpio(pins, pp->name, 0);
>   		conf->name = pp->name;
>   		grp->pins[i] = conf->pin;

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
