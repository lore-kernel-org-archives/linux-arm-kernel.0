From: lkp@intel.com (kbuild test robot)
Date: Thu, 24 Nov 2016 08:00:03 +0800
Subject: [PATCH RESEND 2/2] gpio: axp209: add pinctrl support
In-Reply-To: <20161123141151.25315-3-quentin.schulz@free-electrons.com>
Message-ID: <201611240704.AptpSMwF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Quentin,

[auto build test ERROR on gpio/for-next]
[also build test ERROR on v4.9-rc6 next-20161123]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Quentin-Schulz/add-support-for-AXP209-GPIOs-functions/20161124-061409
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next
config: tile-allmodconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 4.6.2
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All errors (new ones prefixed by >>):

   drivers/gpio/gpio-axp209.c:100:2: error: field name not in record or union initializer
   drivers/gpio/gpio-axp209.c:100:2: error: (near initialization for
   drivers/gpio/gpio-axp209.c:100:2: error: field name not in record or union initializer
   drivers/gpio/gpio-axp209.c:100:2: error: (near initialization for
   drivers/gpio/gpio-axp209.c:100:2: error: field name not in record or union initializer
   drivers/gpio/gpio-axp209.c:100:2: error: (near initialization for
   drivers/gpio/gpio-axp209.c:105:2: error: field name not in record or union initializer
   drivers/gpio/gpio-axp209.c:105:2: error: (near initialization for
   drivers/gpio/gpio-axp209.c:105:2: error: field name not in record or union initializer
   drivers/gpio/gpio-axp209.c:105:2: error: (near initialization for
   drivers/gpio/gpio-axp209.c:105:2: error: field name not in record or union initializer
   drivers/gpio/gpio-axp209.c:105:2: error: (near initialization for
   drivers/gpio/gpio-axp209.c: In function 'axp20x_gpio_get_direction':
   drivers/gpio/gpio-axp209.c:131:49: error: request for member 'drv_data' in something not a structure or union
   drivers/gpio/gpio-axp209.c:131:16: warning: cast from pointer to integer of different size
   drivers/gpio/gpio-axp209.c: In function 'axp20x_gpio_set':
   drivers/gpio/gpio-axp209.c:158:49: error: request for member 'drv_data' in something not a structure or union
   drivers/gpio/gpio-axp209.c:158:16: warning: cast from pointer to integer of different size
   drivers/gpio/gpio-axp209.c: In function 'axp20x_gpio_input':
   drivers/gpio/gpio-axp209.c:168:2: error: implicit declaration of function 'pinctrl_gpio_direction_input'
   drivers/gpio/gpio-axp209.c: In function 'axp20x_pmx_set':
   drivers/gpio/gpio-axp209.c:182:9: error: implicit declaration of function 'pinctrl_dev_get_drvdata'
   drivers/gpio/gpio-axp209.c:182:29: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/gpio/gpio-axp209.c:183:49: error: request for member 'drv_data' in something not a structure or union
   drivers/gpio/gpio-axp209.c:183:16: warning: cast from pointer to integer of different size
   drivers/gpio/gpio-axp209.c: In function 'axp20x_pmx_func_cnt':
   drivers/gpio/gpio-axp209.c:191:29: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/gpio/gpio-axp209.c: In function 'axp20x_pmx_func_name':
   drivers/gpio/gpio-axp209.c:199:29: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/gpio/gpio-axp209.c: In function 'axp20x_pmx_func_groups':
   drivers/gpio/gpio-axp209.c:209:29: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/gpio/gpio-axp209.c: In function 'axp20x_pinctrl_desc_find_func_by_name':
   drivers/gpio/gpio-axp209.c:228:23: error: request for member 'name' in something not a structure or union
   drivers/gpio/gpio-axp209.c:228:3: warning: passing argument 1 of 'strcmp' from incompatible pointer type [enabled by default]
   include/linux/string.h:42:12: note: expected 'const char but argument is of type 'const struct axp20x_desc_pin
   drivers/gpio/gpio-axp209.c: In function 'axp20x_pmx_set_mux':
   drivers/gpio/gpio-axp209.c:253:29: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/gpio/gpio-axp209.c: In function 'axp20x_pctl_desc_find_func_by_pin':
   drivers/gpio/gpio-axp209.c:276:15: error: request for member 'number' in something not a structure or union
   drivers/gpio/gpio-axp209.c:276:23: warning: comparison between pointer and integer [enabled by default]
   drivers/gpio/gpio-axp209.c: At top level:
   drivers/gpio/gpio-axp209.c:293:7: warning: 'struct pinctrl_gpio_range' declared inside parameter list [enabled by default]
   drivers/gpio/gpio-axp209.c:293:7: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
   drivers/gpio/gpio-axp209.c: In function 'axp20x_pmx_gpio_set_direction':
   drivers/gpio/gpio-axp209.c:295:29: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/gpio/gpio-axp209.c: At top level:
   drivers/gpio/gpio-axp209.c:311:21: error: variable 'axp20x_pmx_ops' has initializer but incomplete type
   drivers/gpio/gpio-axp209.c:312:2: error: unknown field 'get_functions_count' specified in initializer
   drivers/gpio/gpio-axp209.c:312:2: warning: excess elements in struct initializer [enabled by default]
   drivers/gpio/gpio-axp209.c:312:2: warning: (near initialization for 'axp20x_pmx_ops') [enabled by default]
   drivers/gpio/gpio-axp209.c:313:2: error: unknown field 'get_function_name' specified in initializer
   drivers/gpio/gpio-axp209.c:313:2: warning: excess elements in struct initializer [enabled by default]
   drivers/gpio/gpio-axp209.c:313:2: warning: (near initialization for 'axp20x_pmx_ops') [enabled by default]
   drivers/gpio/gpio-axp209.c:314:2: error: unknown field 'get_function_groups' specified in initializer
   drivers/gpio/gpio-axp209.c:314:2: warning: excess elements in struct initializer [enabled by default]
   drivers/gpio/gpio-axp209.c:314:2: warning: (near initialization for 'axp20x_pmx_ops') [enabled by default]
   drivers/gpio/gpio-axp209.c:315:2: error: unknown field 'set_mux' specified in initializer
   drivers/gpio/gpio-axp209.c:315:2: warning: excess elements in struct initializer [enabled by default]
   drivers/gpio/gpio-axp209.c:315:2: warning: (near initialization for 'axp20x_pmx_ops') [enabled by default]
   drivers/gpio/gpio-axp209.c:316:2: error: unknown field 'gpio_set_direction' specified in initializer
   drivers/gpio/gpio-axp209.c:316:2: warning: excess elements in struct initializer [enabled by default]
   drivers/gpio/gpio-axp209.c:316:2: warning: (near initialization for 'axp20x_pmx_ops') [enabled by default]
   drivers/gpio/gpio-axp209.c:317:2: error: unknown field 'strict' specified in initializer
   drivers/gpio/gpio-axp209.c:317:2: warning: excess elements in struct initializer [enabled by default]
   drivers/gpio/gpio-axp209.c:317:2: warning: (near initialization for 'axp20x_pmx_ops') [enabled by default]
   drivers/gpio/gpio-axp209.c: In function 'axp20x_groups_cnt':
   drivers/gpio/gpio-axp209.c:322:29: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/gpio/gpio-axp209.c: In function 'axp20x_group_pins':
   drivers/gpio/gpio-axp209.c:330:29: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/gpio/gpio-axp209.c: In function 'axp20x_group_name':
   drivers/gpio/gpio-axp209.c:342:29: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/gpio/gpio-axp209.c: At top level:
   drivers/gpio/gpio-axp209.c:347:21: error: variable 'axp20x_pctrl_ops' has initializer but incomplete type
   drivers/gpio/gpio-axp209.c:348:2: error: unknown field 'dt_node_to_map' specified in initializer
   drivers/gpio/gpio-axp209.c:348:21: error: 'pinconf_generic_dt_node_to_map_group' undeclared here (not in a function)
   drivers/gpio/gpio-axp209.c:348:2: warning: excess elements in struct initializer [enabled by default]
   drivers/gpio/gpio-axp209.c:348:2: warning: (near initialization for 'axp20x_pctrl_ops') [enabled by default]
   drivers/gpio/gpio-axp209.c:349:2: error: unknown field 'dt_free_map' specified in initializer
   drivers/gpio/gpio-axp209.c:349:18: error: 'pinconf_generic_dt_free_map' undeclared here (not in a function)
   drivers/gpio/gpio-axp209.c:349:2: warning: excess elements in struct initializer [enabled by default]
   drivers/gpio/gpio-axp209.c:349:2: warning: (near initialization for 'axp20x_pctrl_ops') [enabled by default]
   drivers/gpio/gpio-axp209.c:350:2: error: unknown field 'get_groups_count' specified in initializer
   drivers/gpio/gpio-axp209.c:350:2: warning: excess elements in struct initializer [enabled by default]
   drivers/gpio/gpio-axp209.c:350:2: warning: (near initialization for 'axp20x_pctrl_ops') [enabled by default]
   drivers/gpio/gpio-axp209.c:351:2: error: unknown field 'get_group_name' specified in initializer
   drivers/gpio/gpio-axp209.c:351:2: warning: excess elements in struct initializer [enabled by default]
   drivers/gpio/gpio-axp209.c:351:2: warning: (near initialization for 'axp20x_pctrl_ops') [enabled by default]
   drivers/gpio/gpio-axp209.c:352:2: error: unknown field 'get_group_pins' specified in initializer
   drivers/gpio/gpio-axp209.c:352:2: warning: excess elements in struct initializer [enabled by default]
   drivers/gpio/gpio-axp209.c:352:2: warning: (near initialization for 'axp20x_pctrl_ops') [enabled by default]
   drivers/gpio/gpio-axp209.c: In function 'axp20x_attach_group_function':
   drivers/gpio/gpio-axp209.c:416:23: error: request for member 'name' in something not a structure or union
   drivers/gpio/gpio-axp209.c:416:13: warning: assignment from incompatible pointer type [enabled by default]
   drivers/gpio/gpio-axp209.c: In function 'axp20x_build_state':
   drivers/gpio/gpio-axp209.c:439:49: error: request for member 'name' in something not a structure or union
   drivers/gpio/gpio-axp209.c:439:24: warning: assignment from incompatible pointer type [enabled by default]
   drivers/gpio/gpio-axp209.c:440:48: error: request for member 'number' in something not a structure or union
   drivers/gpio/gpio-axp209.c:440:23: warning: assignment makes integer from pointer without a cast [enabled by default]
   drivers/gpio/gpio-axp209.c: In function 'axp20x_pctl_probe':
   drivers/gpio/gpio-axp209.c:522:61: error: dereferencing pointer to incomplete type
>> drivers/gpio/gpio-axp209.c:522:52: error: invalid operands to binary Makefile arch drivers include kernel scripts source (have 'int' and 'const struct axp20x_desc_pin
   drivers/gpio/gpio-axp209.c:523:8: warning: passing argument 2 of 'devm_kzalloc' makes integer from pointer without a cast [enabled by default]
   include/linux/device.h:658:21: note: expected 'size_t' but argument is of type 'const struct axp20x_desc_pin
   drivers/gpio/gpio-axp209.c:528:3: error: invalid use of undefined type 'struct pinctrl_pin_desc'
   drivers/gpio/gpio-axp209.c:528:7: error: dereferencing pointer to incomplete type
   drivers/gpio/gpio-axp209.c:528:3: warning: statement with no effect
   drivers/gpio/gpio-axp209.c:530:47: error: dereferencing pointer to incomplete type
   drivers/gpio/gpio-axp209.c:530:2: warning: passing argument 2 of 'devm_kzalloc' makes integer from pointer without a cast [enabled by default]
   include/linux/device.h:658:21: note: expected 'size_t' but argument is of type 'const struct axp20x_desc_pin
   drivers/gpio/gpio-axp209.c:534:12: error: dereferencing pointer to incomplete type
   drivers/gpio/gpio-axp209.c:534:12: error: request for member 'name' in something not a structure or union
   drivers/gpio/gpio-axp209.c:534:2: warning: statement with no effect
   drivers/gpio/gpio-axp209.c:535:12: error: dereferencing pointer to incomplete type
   drivers/gpio/gpio-axp209.c:535:12: error: request for member 'owner' in something not a structure or union
   drivers/gpio/gpio-axp209.c:535:2: warning: statement with no effect
   drivers/gpio/gpio-axp209.c:536:12: error: dereferencing pointer to incomplete type
   drivers/gpio/gpio-axp209.c:536:12: error: request for member 'pins' in something not a structure or union
   drivers/gpio/gpio-axp209.c:536:2: warning: statement with no effect
   drivers/gpio/gpio-axp209.c:537:12: error: dereferencing pointer to incomplete type
   drivers/gpio/gpio-axp209.c:537:12: error: request for member 'npins' in something not a structure or union
   drivers/gpio/gpio-axp209.c:537:2: warning: statement with no effect
   drivers/gpio/gpio-axp209.c:538:12: error: dereferencing pointer to incomplete type
   drivers/gpio/gpio-axp209.c:538:12: error: request for member 'pctlops' in something not a structure or union
   drivers/gpio/gpio-axp209.c:538:2: warning: statement with no effect
   drivers/gpio/gpio-axp209.c:539:12: error: dereferencing pointer to incomplete type
   drivers/gpio/gpio-axp209.c:539:12: error: request for member 'pmxops' in something not a structure or union
   drivers/gpio/gpio-axp209.c:539:2: warning: statement with no effect
   drivers/gpio/gpio-axp209.c:541:2: error: implicit declaration of function 'devm_pinctrl_register'
   drivers/gpio/gpio-axp209.c:541:17: warning: assignment makes pointer from integer without a cast [enabled by default]
   drivers/gpio/gpio-axp209.c:557:19: error: request for member 'number' in something not a structure or union
   drivers/gpio/gpio-axp209.c:557:36: error: request for member 'number' in something not a structure or union
   drivers/gpio/gpio-axp209.c:558:11: warning: passing argument 3 of 'gpiochip_add_pin_range' makes integer from pointer without a cast [enabled by default]
   include/linux/gpio/driver.h:324:1: note: expected 'unsigned int' but argument is of type 'const struct axp20x_desc_pin
   drivers/gpio/gpio-axp209.c:558:11: warning: passing argument 4 of 'gpiochip_add_pin_range' makes integer from pointer without a cast [enabled by default]
   include/linux/gpio/driver.h:324:1: note: expected 'unsigned int' but argument is of type 'const struct axp20x_desc_pin
   cc1: some warnings being treated as errors

vim +522 drivers/gpio/gpio-axp209.c

   410			}
   411	
   412			func_grp = func->groups;
   413			while (*func_grp)
   414				func_grp++;
   415	
 > 416			*func_grp = pin->pin.name;
   417			desc_func++;
   418		}
   419	
   420		return 0;
   421	}
   422	
   423	static int axp20x_build_state(struct platform_device *pdev)
   424	{
   425		struct axp20x_pctl *pctl = platform_get_drvdata(pdev);
   426		unsigned int npins = pctl->desc->npins;
   427		const struct axp20x_desc_pin *pin;
   428		struct axp20x_desc_function *func;
   429		int i, ret;
   430	
   431		pctl->ngroups = npins;
   432		pctl->groups = devm_kzalloc(&pdev->dev,
   433					    pctl->ngroups * sizeof(*pctl->groups),
   434					    GFP_KERNEL);
   435		if (!pctl->groups)
   436			return -ENOMEM;
   437	
   438		for (i = 0; i < npins; i++) {
   439			pctl->groups[i].name = pctl->desc->pins[i].pin.name;
   440			pctl->groups[i].pin = pctl->desc->pins[i].pin.number;
   441		}
   442	
   443		/* We assume 4 functions per pin should be enough as a default max */
   444		pctl->functions = devm_kzalloc(&pdev->dev,
   445					       npins * 4 * sizeof(*pctl->functions),
   446					       GFP_KERNEL);
   447		if (!pctl->functions)
   448			return -ENOMEM;
   449	
   450		/* Create a list of uniquely named functions */
   451		for (i = 0; i < npins; i++) {
   452			pin = &pctl->desc->pins[i];
   453			func = pin->functions;
   454	
   455			while (func->name) {
   456				axp20x_pinctrl_add_function(pctl, func->name);
   457				func++;
   458			}
   459		}
   460	
   461		pctl->functions = krealloc(pctl->functions,
   462					   pctl->nfunctions * sizeof(*pctl->functions),
   463					   GFP_KERNEL);
   464	
   465		for (i = 0; i < npins; i++) {
   466			pin = &pctl->desc->pins[i];
   467			ret = axp20x_attach_group_function(pdev, pin);
   468			if (ret)
   469				return ret;
   470		}
   471	
   472		return 0;
   473	}
   474	
   475	static int axp20x_pctl_probe(struct platform_device *pdev)
   476	{
   477		struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
   478		const struct axp20x_desc_pin *pin;
   479		struct axp20x_pctl *pctl;
   480		struct pinctrl_desc *pctrl_desc;
   481		struct pinctrl_pin_desc *pins;
   482		int ret, i;
   483	
   484		if (!of_device_is_available(pdev->dev.of_node))
   485			return -ENODEV;
   486	
   487		if (!axp20x) {
   488			dev_err(&pdev->dev, "Parent drvdata not set\n");
   489			return -EINVAL;
   490		}
   491	
   492		pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
   493		if (!pctl)
   494			return -ENOMEM;
   495	
   496		pctl->chip.base			= -1;
   497		pctl->chip.can_sleep		= true;
   498		pctl->chip.request		= gpiochip_generic_request;
   499		pctl->chip.free			= gpiochip_generic_free;
   500		pctl->chip.parent		= &pdev->dev;
   501		pctl->chip.label		= dev_name(&pdev->dev);
   502		pctl->chip.owner		= THIS_MODULE;
   503		pctl->chip.get			= axp20x_gpio_get;
   504		pctl->chip.get_direction	= axp20x_gpio_get_direction;
   505		pctl->chip.set			= axp20x_gpio_set;
   506		pctl->chip.direction_input	= axp20x_gpio_input;
   507		pctl->chip.direction_output	= axp20x_gpio_output;
   508		pctl->chip.ngpio		= 3;
   509		pctl->chip.can_sleep		= true;
   510	
   511		pctl->regmap = axp20x->regmap;
   512	
   513		pctl->desc = &axp20x_pinctrl_data;
   514		pctl->dev = &pdev->dev;
   515	
   516		platform_set_drvdata(pdev, pctl);
   517	
   518		ret = axp20x_build_state(pdev);
   519		if (ret)
   520			return ret;
   521	
 > 522		pins = devm_kzalloc(&pdev->dev, pctl->desc->npins * sizeof(*pins),
   523				    GFP_KERNEL);
   524		if (!pins)
   525			return -ENOMEM;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 46296 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161124/f51c9ead/attachment-0001.gz>
