From: stillcompiling@gmail.com (Joshua Clayton)
Date: Wed, 20 May 2015 07:46:18 -0700
Subject: [PATCH v2 0/7] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
In-Reply-To: <CAHrpEqSpeMO=zLyii8qZUznP+9EAQqJ-D3O8hbXj99m+UNvpzA@mail.gmail.com>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
 <20150520142205.GA24844@dragon>
 <CAHrpEqSpeMO=zLyii8qZUznP+9EAQqJ-D3O8hbXj99m+UNvpzA@mail.gmail.com>
Message-ID: <6111368.e0EOBSJsmZ@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> +       snvs_np = of_get_parent(pdev->dev.of_node);
> +       if (!snvs_np)
> +               return -ENODEV;
> +
> +       data->snvs = syscon_node_to_regmap(snvs_np);
> +       of_node_put(snvs_np);
> +
> +       if (!data->snvs) {
> +               pr_err("Can't snvs syscon\n");
> +               return -ENODEV;
> +       }
> 
> How about change error message to " Can't snvs syscon, probably use
> old dts file"?
How about simply: "Cannot find snvs syscon node in devicetree."


-- 
~Joshua Clayton
