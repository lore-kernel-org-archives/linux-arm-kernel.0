From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 13 Nov 2018 10:00:58 -0800
Subject: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
In-Reply-To: <20181113095210.mh3iy5tcsu6w6tem@pengutronix.de>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
 <20181113095210.mh3iy5tcsu6w6tem@pengutronix.de>
Message-ID: <154213205843.88331.7023190778461777093@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Uwe Kleine-K?nig (2018-11-13 01:52:10)
> 
> I wonder if it would make sense to introduce functions like:
> 
>         struct clk *clk_get_optional(struct device *dev, const char *id)
> 
> that return NULL instead of ERR_PTR(-ENODEV).
> 
> Then the above would simplify to:
> 
>         pc->clks[i] = devm_clk_get_optional(&pdev->dev, mtk_pwm_clk_name[i]);
>         if (IS_ERR(pc->clks[i]) {
>                 if (PTR_ERR(pc->clks[i]) == -EPROBE_DEFER)
>                         dev_err(...);
>                 return PTR_ERR(pc->clks[i]);
>         }
> 
> (added the clk people to Cc for this question).
> 

Such a patch is already on the list and not getting much review.

http://lkml.kernel.org/r/1535724443-21150-1-git-send-email-phil.edworthy at renesas.com
