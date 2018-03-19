From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 13:31:59 -0700
Subject: [PATCH v4 2/6] clk: mediatek: add devm_of_platform_populate() for
 MT7622 audsys
In-Reply-To: <3a3c198707a69297abc05d2a7fef97857e7fab5a.1520327262.git.ryder.lee@mediatek.com>
References: <cover.1520327262.git.ryder.lee@mediatek.com>
 <3a3c198707a69297abc05d2a7fef97857e7fab5a.1520327262.git.ryder.lee@mediatek.com>
Message-ID: <152149151947.242365.12823569223681242175@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ryder Lee (2018-03-06 01:09:27)
> @@ -150,12 +151,15 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
>                                clk_data);
>  
>         r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> -       if (r)
> +       if (r) {
>                 dev_err(&pdev->dev,
>                         "could not register clock provider: %s: %d\n",
>                         pdev->name, r);
>  
> -       return r;
> +               return r;
> +       }
> +
> +       return devm_of_platform_populate(&pdev->dev);

And now we fail to remove the clk provider when this fails.

>  }
>  
>  static const struct of_device_id of_match_clk_mt7622_aud[] = {
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
