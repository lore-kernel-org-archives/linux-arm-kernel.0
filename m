From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Tue, 1 Nov 2011 09:02:08 +0100
Subject: [PATCH] i2c-gpio.c: correct logic of pdata->scl_is_open_drain
In-Reply-To: <CAF8ieYWY2RwkgPERgagvw2bby8Y+UFgrYr3zPOb27e=bfOH-vg@mail.gmail.com>
References: <EF2E73589CA71846A15D0B2CDF79505D087B34BE51@wm021.weinmann.com>
	<CAF8ieYXPMgUzekth7PGxC3AgYNKac-HQ21D3vvB5J3SLOatmfQ@mail.gmail.com>
	<EF2E73589CA71846A15D0B2CDF79505D087B34BE8B@wm021.weinmann.com>
	<CAF8ieYWY2RwkgPERgagvw2bby8Y+UFgrYr3zPOb27e=bfOH-vg@mail.gmail.com>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D087B34BEE2@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> It is never correct to use push-pull I/O for i2c, so the flag does not
> specify the desired behavior of the driver, it specifies what the
> hardware has been configured to do so that the driver can choose the
> cheapest way to do open-drain I/O.

Ok, seems rather logical after all.

> 
> And even if you could argue that the flag should be inverted, it has
> had the same meaning since the driver was introduced several years
> ago, so changing it now will break every single platform which
> currently uses i2c-gpio.

I completely agree.

Thanks for the explanation,
Niko
