From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Fri, 05 Dec 2014 09:59:53 +0200
Subject: [PATCH v2 7/7] pinctrl: qcom-spmi-gpio: Migrate to pinconf-generic
In-Reply-To: <1417137993-8337-8-git-send-email-soren.brinkmann@xilinx.com>
References: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
 <1417137993-8337-8-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1417766393.22963.9.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2014-11-27 at 17:26 -0800, Soren Brinkmann wrote:
> 
>  static const struct pinconf_ops pmic_gpio_pinconf_ops = {
> +       .is_generic= true,
>         .pin_config_group_get= pmic_gpio_config_get,
>         .pin_config_group_set= pmic_gpio_config_set,
>         .pin_config_group_dbg_show= pmic_gpio_config_dbg_show,
> @@ -848,6 +742,9 @@ static int pmic_gpio_probe(struct platform_device *pdev)
>         pctrldesc->name = dev_name(dev);
>         pctrldesc->pins = pindesc;
>         pctrldesc->npins = npins;
> +       pctrldesc->num_dt_params = ARRAY_SIZE(pmic_gpio_bindings);
> +       pctrldesc->params = pmic_gpio_bindings;
> +       pctrldesc->conf_items = pmic_conf_items;
> 

What will happen if number of conf_items is less than number of params?

Ivan
