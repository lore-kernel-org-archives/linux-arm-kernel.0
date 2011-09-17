From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Sep 2011 20:40:54 +0200
Subject: [PATCH v2] pata-generic/of: Make probing via device tree
	non-powerpc-specific
In-Reply-To: <20110917153732.GR3523@ponder.secretlab.ca>
References: <1316183890-13677-1-git-send-email-dave.martin@linaro.org>
	<1316190120-17010-1-git-send-email-dave.martin@linaro.org>
	<20110917153732.GR3523@ponder.secretlab.ca>
Message-ID: <2615461.zA8fCfbHH2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 September 2011 09:37:32 Grant Likely wrote:
> What driver is normally used for versatile express pata?  This driver
> is kind of legacy in that it was created when there was a split
> between platform_device and of_platform_devices.  But that split was a
> bad idea and the same driver should be used regardless of whether or
> not DT is enabled.  pata_of_platform.c really should be removed.

It normally uses the plain pata_platform.c driver.

Note that the pata_of_platform driver is already just a shim on
top of the regular pata_platform driver. They could easily be combined,
but the current state is also ok, since there is very little code
duplication.

	Arnd
