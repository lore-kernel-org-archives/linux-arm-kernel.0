From: collinsd@codeaurora.org (David Collins)
Date: Mon, 19 Mar 2018 14:47:29 -0700
Subject: [PATCH] regulator: fix platform_no_drv_owner.cocci warnings
In-Reply-To: <20180318203832.GA74597@lkp-hsx03.lkp.intel.com>
References: <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <20180318203832.GA74597@lkp-hsx03.lkp.intel.com>
Message-ID: <d7f7ade6-865a-00da-b4c9-6225b8822ec0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2018 01:38 PM, kbuild test robot wrote:
> From: Fengguang Wu <fengguang.wu@intel.com>
> 
> drivers/regulator/qcom_rpmh-regulator.c:1104:3-8: 
> No need to set .owner here. The core will do it.

Thanks for pointing this out.

> --- a/drivers/regulator/qcom_rpmh-regulator.c
> +++ b/drivers/regulator/qcom_rpmh-regulator.c
> @@ -1101,7 +1101,6 @@ static struct platform_driver rpmh_regul
>  	.driver		= {
>  		.name		= "qcom-rpmh-regulator",
>  		.of_match_table	= rpmh_regulator_match_table,
> -		.owner		= THIS_MODULE,
>  	},
>  	.probe		= rpmh_regulator_probe,
>  	.remove		= rpmh_regulator_remove,

I'll make this modification in [1] if I end up sending out a second
version of the patch.

Take care,
David

[1]: https://lkml.org/lkml/2018/3/16/1430

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
