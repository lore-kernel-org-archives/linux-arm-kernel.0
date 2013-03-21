From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 21 Mar 2013 14:00:19 -0700
Subject: [PATCH V2 2/3] clk: Improve errorhandling for clk_set_parent
In-Reply-To: <1363873693-30902-3-git-send-email-ulf.hansson@stericsson.com>
References: <1363873693-30902-1-git-send-email-ulf.hansson@stericsson.com>
 <1363873693-30902-3-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20130321210019.834.12024@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ulf Hansson (2013-03-21 06:48:12)
> @@ -1344,8 +1341,9 @@ out:
>  int clk_set_parent(struct clk *clk, struct clk *parent)
>  {
>         int ret = 0;
> +       u8 p_index;
>  
> -       if (!clk || !clk->ops)
> +       if (!clk || !clk->ops || !parent)
>                 return -EINVAL;
>  

A NULL clock is valid according to the clk.h api.  I would like to allow
parent to be NULL, resulting in a migration from the real clock tree to
the orphans list.

This feature was apparently buggy for some time and Rajagopal sent me a
patch off-list to fix it.  Rajagopal, can you post your patch publicly?

Thanks,
Mike
