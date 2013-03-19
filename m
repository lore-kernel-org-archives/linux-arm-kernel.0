From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 19 Mar 2013 20:41:41 +0100
Subject: [PATCH] pinctrl: mvebu: fix checking for SoC specific controls
In-Reply-To: <1363720062-21395-1-git-send-email-simon.guinot@sequanux.org>
References: <1363720062-21395-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <5148BF75.8080204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2013 08:07 PM, Simon Guinot wrote:
> This patch fixes a minor bug (probably due to a typo) while checking
> the SoC specific controls in mvebu_pinctrl_probe().
>
> Signed-off-by: Simon Guinot<simon.guinot@sequanux.org>

Simon,

good catch! The patch looks sane to me, so

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   drivers/pinctrl/mvebu/pinctrl-mvebu.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> index c689c04..2d2f0a4 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> @@ -620,7 +620,7 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
>
>   		/* special soc specific control */
>   		if (ctrl->mpp_get || ctrl->mpp_set) {
> -			if (!ctrl->name || !ctrl->mpp_set || !ctrl->mpp_set) {
> +			if (!ctrl->name || !ctrl->mpp_get || !ctrl->mpp_set) {
>   				dev_err(&pdev->dev, "wrong soc control info\n");
>   				return -EINVAL;
>   			}
