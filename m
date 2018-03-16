From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 16 Mar 2018 16:02:53 -0700
Subject: [PATCH v6 16/20] clk: add support for clocks provided by SCMI
In-Reply-To: <1519403030-21189-17-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
 <1519403030-21189-17-git-send-email-sudeep.holla@arm.com>
Message-ID: <152124137391.242365.17144416413429914606@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sudeep Holla (2018-02-23 08:23:46)
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> new file mode 100644
> index 000000000000..1e4d7a57779b
> --- /dev/null
> +++ b/drivers/clk/clk-scmi.c
> +                       hws[idx] = &sclk->hw;
> +               }
> +       }
> +
> +       return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);

devm_of_clk_add_hw_provider?

> +}
> +
> +static void scmi_clocks_remove(struct scmi_device *sdev)
> +{
> +       struct device *dev = &sdev->dev;
> +       struct device_node *np = dev->of_node;
> +
> +       of_clk_del_provider(np);
> +}
> +

Drop?

You can keep my acked-by otherwise.
