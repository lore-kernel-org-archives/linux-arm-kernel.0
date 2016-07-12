From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 12 Jul 2016 12:39:47 +0200 (CEST)
Subject: [stericsson:sensors 5/5] drivers/iio/magnetometer/ak8974.c:502:2-8:
 preceding lock on line 498 (fwd)
Message-ID: <alpine.DEB.2.10.1607121239170.3034@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks suspicious, please check.

julia

---------- Forwarded message ----------
Date: Tue, 12 Jul 2016 18:13:49 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild at 01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [stericsson:sensors 5/5] drivers/iio/magnetometer/ak8974.c:502:2-8:
    preceding lock on line 498

CC: kbuild-all at 01.org
CC: linux-arm-kernel at lists.infradead.org
CC: Linus Walleij <linus.walleij@linaro.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git sensors
head:   90fbcae458710a6e8e16e9b2a9a54e27bc73ec82
commit: 90fbcae458710a6e8e16e9b2a9a54e27bc73ec82 [5/5] iio: magn: add a driver for AK8974
:::::: branch date: 2 hours ago
:::::: commit date: 2 hours ago

>> drivers/iio/magnetometer/ak8974.c:502:2-8: preceding lock on line 498
   drivers/iio/magnetometer/ak8974.c:467:3-9: preceding lock on line 463

git remote add stericsson https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
git remote update stericsson
git checkout 90fbcae458710a6e8e16e9b2a9a54e27bc73ec82
vim +502 drivers/iio/magnetometer/ak8974.c

90fbcae4 Linus Walleij 2016-06-21  492  {
90fbcae4 Linus Walleij 2016-06-21  493  	struct ak8974 *ak8974 = iio_priv(indio_dev);
90fbcae4 Linus Walleij 2016-06-21  494  	int ret;
90fbcae4 Linus Walleij 2016-06-21  495  	s16 hw_values[8]; /* Three axes + 64bit padding */
90fbcae4 Linus Walleij 2016-06-21  496
90fbcae4 Linus Walleij 2016-06-21  497  	pm_runtime_get_sync(&ak8974->i2c->dev);
90fbcae4 Linus Walleij 2016-06-21 @498  	mutex_lock(&ak8974->lock);
90fbcae4 Linus Walleij 2016-06-21  499  	ret = ak8974_trigmeas(ak8974);
90fbcae4 Linus Walleij 2016-06-21  500  	if (ret) {
90fbcae4 Linus Walleij 2016-06-21  501  		dev_err(&ak8974->i2c->dev, "error triggering measure\n");
90fbcae4 Linus Walleij 2016-06-21 @502  		return;
90fbcae4 Linus Walleij 2016-06-21  503  	}
90fbcae4 Linus Walleij 2016-06-21  504  	ret = ak8974_getresult(ak8974, hw_values);
90fbcae4 Linus Walleij 2016-06-21  505  	if (ret) {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
