From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Tue, 18 Nov 2014 10:50:21 +0200
Subject: [PATCH 3/7] pinctrl: pinconf-generic: Allow driver to specify
 DT params
In-Reply-To: <CACRpkdYfj2ydLQ4q_FKwXo73jzNsvj9u2Aem9EiuEw-OCvurrg@mail.gmail.com>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-4-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdYfj2ydLQ4q_FKwXo73jzNsvj9u2Aem9EiuEw-OCvurrg@mail.gmail.com>
Message-ID: <1416300621.30131.6.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 2014-11-11 at 15:53 +0100, Linus Walleij wrote:
> On Mon, Nov 3, 2014 at 8:05 PM, Soren Brinkmann
> brinkmann at xilinx.com> wrote:
> 
> > Additionally to the generic DT parameters, allow drivers to provide
> > driver-specific DT parameters to be used with the generic parser
> > infrastructure.
> > 
> > Signed-off-by: Soren Brinkmann brinkmann at xilinx.com>
> 
> I like the looks of this, but the patch description is a bit terse.
> I'd like it to describe some of the refactorings being done
> to the intrinsics, because I have a hard time following the patch.
> 
> First please rebase onto the "devel" branch in the pin control
> tree, and notice that drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> which is merged there is actually doing this already:
> 
> 
>         for_each_child_of_node(np_config, np) {
>                 ret = pinconf_generic_dt_subnode_to_map(pctldev, np, map,
>                                                         &reserv, nmaps, type);
>                 if (ret)
>                         break;
> 
>                 ret = pmic_gpio_dt_subnode_to_map(pctldev, np, map, &reserv,
>                                                   nmaps, type);
>                 if (ret)
>                         break;
>         }
> 
> So it should be patched to illustrate the point of this code.
> 

I like the idea, but have issues with implementations :-). 
 
It is supposed that additional parameters are not generic, 
otherwise they will be part of enum pin_config_param, right?

Probably it will be better if clients could pass array with
driver specific dt bindings to pinconf_generic_dt_node_to_map()?

Regards,
Ivan
