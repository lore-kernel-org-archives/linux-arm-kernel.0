From: madhu.sk89@gmail.com (Madhu K)
Date: Wed, 19 Jul 2017 15:35:20 +0530
Subject: What is use of struct i2c_device_id if we are already using struct
 of_device_id?
Message-ID: <CAA2oCOm-xDd6GbowfXrL-QU5fDmmCkn7LmNS=Z==o_nM4DTomQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I am kernel newbie, I am trying to understand some basics of linux
device drivers, as part of my course, i came across below scenario
where both i2c_device_id and of_device_id are used.

what is the purpose of having both the structures?

Below is the code

static const struct i2c_device_id ad7879_id[] = {
{ "ad7879", 0 },
{ "ad7889", 0 },
{ }
};
MODULE_DEVICE_TABLE(i2c, ad7879_id);

#ifdef CONFIG_OF
static const struct of_device_id ad7879_i2c_dt_ids[] = {
{ .compatible = "adi,ad7879-1", },
{ }
};
MODULE_DEVICE_TABLE(of, ad7879_i2c_dt_ids);
#endif

static struct i2c_driver ad7879_i2c_driver = {
.driver = {
.name = "ad7879",
.pm = &ad7879_pm_ops,
.of_match_table = of_match_ptr(ad7879_i2c_dt_ids),
},
.probe = ad7879_i2c_probe,
.id_table = ad7879_id,
};


Thanks & regards,
Madhu
