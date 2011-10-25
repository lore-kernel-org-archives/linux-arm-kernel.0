From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 24 Oct 2011 21:07:33 -0700
Subject: [PATCH 1/1] pinctrl/sirf: fix sirfsoc_get_group_pins prototype
	introduce in 7e570f97
In-Reply-To: <1319472717-20159-1-git-send-email-plagnioj@jcrosoft.com>
References: <1319472717-20159-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173E1B4170@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean-Christophe PLAGNIOL-VILLARD wrote at Monday, October 24, 2011 10:12 AM:
...
> diff --git a/drivers/pinctrl/pinmux-sirf.c b/drivers/pinctrl/pinmux-sirf.c
> index ba73523..d76cae6 100644
> --- a/drivers/pinctrl/pinmux-sirf.c
> +++ b/drivers/pinctrl/pinmux-sirf.c
> @@ -870,7 +870,7 @@ static const char *sirfsoc_get_group_name(struct pinctrl_dev *pctldev,
> 
>  static int sirfsoc_get_group_pins(struct pinctrl_dev *pctldev, unsigned selector,
>  			       const unsigned **pins,
> -			       const unsigned *num_pins)
> +			       unsigned *num_pins)
>  {
>  	if (selector >= ARRAY_SIZE(sirfsoc_pin_groups))
>  		return -EINVAL;

Acked-by: Stephen Warren <swarren@nvidia.com>

That'll teach me to only test-compile for U300 and not Sirf... I thought
I'd made the same change to each, but I screwed up Sirf.

-- 
nvpublic
