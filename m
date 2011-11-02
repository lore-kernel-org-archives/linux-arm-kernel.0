From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Wed, 2 Nov 2011 06:56:50 +0100
Subject: [PATCH] i2c-gpio.c: correct logic of pdata->scl_is_open_drain
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F39DF77673@AUSP01VMBX24.collaborationhost.net>
References: <EF2E73589CA71846A15D0B2CDF79505D087B34BE51@wm021.weinmann.com>
	<CAF8ieYXPMgUzekth7PGxC3AgYNKac-HQ21D3vvB5J3SLOatmfQ@mail.gmail.com>
	<EF2E73589CA71846A15D0B2CDF79505D087B34BE8B@wm021.weinmann.com>
	<CAF8ieYWY2RwkgPERgagvw2bby8Y+UFgrYr3zPOb27e=bfOH-vg@mail.gmail.com>
	<EF2E73589CA71846A15D0B2CDF79505D087B34BEE2@wm021.weinmann.com>
	<ADE657CA350FB648AAC2C43247A983F001F39DF77673@AUSP01VMBX24.collaborationhost.net>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D087B34C115@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If the "is_open_drain" flags are not set, the I2C bus works correctly
> regardless of the existence of the pull-ups.

No, I2C can only work with anything pulling up SDA weakly, usually an
external pullup. This is independent of the "is_open_drain" property
which only describes how the driver internally accomplishes the high
impedance state.

SCL can be driven push-pull ("scl_is_output_only") but will not be
I2C-compliant any more (no clock stretching), and only clients not relying
on that feature will work.

Niko
