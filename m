From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 26 Jun 2014 14:03:46 +0200
Subject: [PATCH] pinctrl: pinctrl-st.c:  Cleaning up if unsigned is less
 than zero
In-Reply-To: <1403782369-10201-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1403782369-10201-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <53AC0C22.9010108@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rickard,

On 06/26/2014 01:32 PM, Rickard Strandqvist wrote:
> Remove checking if a unsigned is less than zero
> 
> This was found using a static code analysis program called
> cppcheck.
> 
> Signed-off-by: Rickard Strandqvist
> <rickard_strandqvist@spectrumdigital.se>

You can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
> --- drivers/pinctrl/pinctrl-st.c |    2 +- 1 file changed, 1
> insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-st.c
> b/drivers/pinctrl/pinctrl-st.c index 1bd6363bc9..f4ee1b1 100644 ---
> a/drivers/pinctrl/pinctrl-st.c +++ b/drivers/pinctrl/pinctrl-st.c 
> @@ -1256,7 +1256,7 @@ static int st_pctl_parse_functions(struct
> device_node *np, func = &info->functions[index]; func->name =
> np->name; func->ngroups = of_get_child_count(np); -	if
> (func->ngroups <= 0) { +	if (func->ngroups == 0) { 
> dev_err(info->dev, "No groups defined\n"); return -EINVAL; }
> 
