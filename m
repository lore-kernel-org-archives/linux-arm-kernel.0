From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 27 Jul 2016 22:58:47 +0800
Subject: [xlnx:master 2556/2625] drivers/input/keyboard/gpio_keys.c:652:22:
 warning: unused variable 'flags'
Message-ID: <201607272242.uWHLM9yq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   4dcc2058b8620d77b8be9940626b339d848c0dfc
commit: ef0a1fd5ad14a1373f9c483a9426e277ca213cab [2556/2625] Merge tag 'v4.5' into master
config: x86_64-randconfig-i0-201630 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.3-14) 4.9.3
reproduce:
        git checkout ef0a1fd5ad14a1373f9c483a9426e277ca213cab
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/input/keyboard/gpio_keys.c: In function 'gpio_keys_get_devtree_pdata':
>> drivers/input/keyboard/gpio_keys.c:652:22: warning: unused variable 'flags' [-Wunused-variable]
      enum of_gpio_flags flags;
                         ^

vim +/flags +652 drivers/input/keyboard/gpio_keys.c

fd05d0892 David Jander               2011-07-09  636  
5d422f2e7 Andy Shevchenko            2014-04-25  637  	pdata = devm_kzalloc(dev,
5d422f2e7 Andy Shevchenko            2014-04-25  638  			     sizeof(*pdata) + nbuttons * sizeof(*button),
219edc717 Alexandre Pereira da Silva 2012-07-29  639  			     GFP_KERNEL);
5d422f2e7 Andy Shevchenko            2014-04-25  640  	if (!pdata)
5d422f2e7 Andy Shevchenko            2014-04-25  641  		return ERR_PTR(-ENOMEM);
fd05d0892 David Jander               2011-07-09  642  
219edc717 Alexandre Pereira da Silva 2012-07-29  643  	pdata->buttons = (struct gpio_keys_button *)(pdata + 1);
219edc717 Alexandre Pereira da Silva 2012-07-29  644  	pdata->nbuttons = nbuttons;
fd05d0892 David Jander               2011-07-09  645  
219edc717 Alexandre Pereira da Silva 2012-07-29  646  	pdata->rep = !!of_get_property(node, "autorepeat", NULL);
fd05d0892 David Jander               2011-07-09  647  
c4dc5f8c9 Laxman Dewangan            2016-01-12  648  	of_property_read_string(node, "label", &pdata->name);
c4dc5f8c9 Laxman Dewangan            2016-01-12  649  
fd05d0892 David Jander               2011-07-09  650  	i = 0;
809d9516d Laxman Dewangan            2016-01-13  651  	for_each_available_child_of_node(node, pp) {
fd05d0892 David Jander               2011-07-09 @652  		enum of_gpio_flags flags;
fd05d0892 David Jander               2011-07-09  653  
1d6a01365 Fabio Estevam              2014-12-13  654  		button = &pdata->buttons[i++];
1d6a01365 Fabio Estevam              2014-12-13  655  
a59cfe931 Nava kishore Manne         2016-03-30  656  		button->gpio = of_get_gpio_flags(pp, 0, &button->irq_flags);
97d86e07b Dmitry Torokhov            2014-11-14  657  		if (button->gpio < 0) {
97d86e07b Dmitry Torokhov            2014-11-14  658  			error = button->gpio;
97d86e07b Dmitry Torokhov            2014-11-14  659  			if (error != -ENOENT) {
e324ce61e Dmitry Torokhov            2012-12-24  660  				if (error != -EPROBE_DEFER)

:::::: The code at line 652 was first introduced by commit
:::::: fd05d08920b54d189aa247c5c5701a08e539ed0b Input: gpio_keys - add support for device-tree platform data

:::::: TO: David Jander <david@protonic.nl>
:::::: CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 23631 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160727/378e4754/attachment-0001.obj>
