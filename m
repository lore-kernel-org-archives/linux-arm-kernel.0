From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 13 Apr 2017 22:25:27 +0800
Subject: [RFC PATCH 1/3] clk: add clk_bulk_get accessories
In-Reply-To: <1491969809-20154-2-git-send-email-aisheng.dong@nxp.com>
References: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
 <1491969809-20154-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170413142527.GD24254@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 12:03:27PM +0800, Dong Aisheng wrote:
...
> @@ -445,6 +543,12 @@ static inline struct clk *clk_get(struct device *dev, const char *id)
>  	return NULL;
>  }
>  
> +static inline int clk_bulk_get(struct device *dev, int num_clks,
> +			       struct clk_bulk_data *clks)
> +{
> +	return NULL;

Here needs to be changed to 'return 0'.

It's catched by 0day robot.

include/linux/clk.h: In function 'clk_bulk_get':
include/linux/stddef.h:7:14: warning: return makes integer from pointer without a cast [-Wint-conversion]
#define NULL ((void *)0)

Good job! Robot!

Regards
Dong Aisheng
