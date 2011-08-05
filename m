From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 5 Aug 2011 18:02:30 +0800
Subject: Shouldn't DT preserve pdev name and id to allow platform_match to
	work?
In-Reply-To: <CACxGe6vg5NTyiDZqqztjtFEfb7si+-=Y7nEy1Y+YMgA5PVXScw@mail.gmail.com>
References: <4E396361.3060307@ti.com>
	<CACxGe6vg5NTyiDZqqztjtFEfb7si+-=Y7nEy1Y+YMgA5PVXScw@mail.gmail.com>
Message-ID: <CAGsJ_4x7LWRGWXsWzMG1FxZPaFYiKSUpSac2PdwH=d6vqFWRfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> auxdata passes platform_data and overrides the device name when there
> is no way easy way to make the driver work without it. ?It handles the
> the current implementation of clocks and regulators which aren't yet
> populated from the device tree. ?It will go away when clock &
> regulator bindings are implemented.
Yes. As OF_DEV_AUXDATA_ID still requires hardware information like
0x48000100 as below, it seems it is not
consistent with the origin purpose of ARM DT.
OF_DEV_AUXDATA_ID("ti,omap-i2c", 0x48000100, "omap-i2c.1", 1, &i2c_pdata)
And the information 0x48000100 is something that doesn't want to be in
kernel codes.it should be only in dts.

-barry
