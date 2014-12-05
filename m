From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 5 Dec 2014 09:08:21 -0800
Subject: [PATCH v2 7/7] pinctrl: qcom-spmi-gpio: Migrate to pinconf-generic
In-Reply-To: <1417766393.22963.9.camel@mm-sol.com>
References: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
 <1417137993-8337-8-git-send-email-soren.brinkmann@xilinx.com>
 <1417766393.22963.9.camel@mm-sol.com>
Message-ID: <bc08b9044a3f46f5a575dca2fa18a663@BY2FFO11FD057.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-12-05 at 09:59AM +0200, Ivan T. Ivanov wrote:
> 
> On Thu, 2014-11-27 at 17:26 -0800, Soren Brinkmann wrote:
> > 
> >  static const struct pinconf_ops pmic_gpio_pinconf_ops = {
> > +       .is_generic= true,
> >         .pin_config_group_get= pmic_gpio_config_get,
> >         .pin_config_group_set= pmic_gpio_config_set,
> >         .pin_config_group_dbg_show= pmic_gpio_config_dbg_show,
> > @@ -848,6 +742,9 @@ static int pmic_gpio_probe(struct platform_device *pdev)
> >         pctrldesc->name = dev_name(dev);
> >         pctrldesc->pins = pindesc;
> >         pctrldesc->npins = npins;
> > +       pctrldesc->num_dt_params = ARRAY_SIZE(pmic_gpio_bindings);
> > +       pctrldesc->params = pmic_gpio_bindings;
> > +       pctrldesc->conf_items = pmic_conf_items;
> > 
> 
> What will happen if number of conf_items is less than number of params?

I suppose bad things :) You're right, that should probably be checked
somewhere. Let me see whether I find a good place to put such a check.

	Thanks,
	S?ren
