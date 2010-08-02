From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 2 Aug 2010 13:04:10 +0900
Subject: S5PC210: how to register remaining i2c{3~7}s?
Message-ID: <AANLkTi=F1dTL_YEaxchJjxw8R+dTCXnrQe8iipAowiAN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Now s5pc210 has total 8 I2Cs but normally Samsung SoCs support 3 I2Cs.
Simply it can be added like this?

#ifdef CONFIG_ARCH_S5PV310
extern void s3c_i2c3_cfg_gpio(struct platform_device *dev);
extern void s3c_i2c4_cfg_gpio(struct platform_device *dev);
...
extern void s3c_i2c7_cfg_gpio(struct platform_device *dev);
#endif

But some boards don't need to use the i2c7 or i2c6 or more.
Then it can be changed to like this

#ifdef CONFIG_ARCH_S5PV310
#ifdef CONFIG_S5PV310_SETUP_I2C3
extern void s3c_i2c3_cfg_gpio(struct platform_device *dev);
#endif
#ifdef CONFIG_S5PV310_SETUP_I2C4
extern void s3c_i2c4_cfg_gpio(struct platform_device *dev);
#endif
...
#ifdef CONFIG_S5PV310_SETUP_I2C7
extern void s3c_i2c7_cfg_gpio(struct platform_device *dev);
#endif
#endif

Which method do you want?

Give your opinions.

Thank you,
Kyungmin Park
