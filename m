From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 30 Mar 2011 17:03:45 +0800
Subject: [PATCH v2 1/1] ARM: imx: add gpu device
In-Reply-To: <20110330081625.GB3195@b20223-02.ap.freescale.net>
References: <1301465128-401-1-git-send-email-richard.zhao@freescale.com>
	<20110330071658.GQ30938@pengutronix.de>
	<20110330081625.GB3195@b20223-02.ap.freescale.net>
Message-ID: <AANLkTimGUvNra0igyUGRJrzj5y3SwYFt4WEGKrLxd88-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> > @@ -203,6 +205,7 @@ static void __init mx35_3ds_init(void)
>> > ? ? ? ? ? ? pr_warn("Init of the debugboard failed, all "
>> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? "devices on the debugboard are unusable.\n");
>> > ? ? imx35_add_imx_i2c0(&mx35_3ds_i2c0_data);
>> > + ? imx35_add_mxc_gpu(&z160_revision);
>> Do you really need to pass this by pointer? Wouldn't
>> imx35_add_mxc_gpu(0) be good enough?
> It's because sometimes z160_revision has different values with different
> TO versions and z160_revision will be dup as plat data.

This is where platform_device_id comes into play, at least by registering
device with different names, e.g. 'imx35-gpu' or 'imx51-gpu', and the
driver can handle.

Difference between steppings is a bit tricky though, I think a QUIRK_
way, and pass combined QUIRK_* flags will be better in imx35_add_mxc_gpu()
function itself.
