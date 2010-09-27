From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Sep 2010 09:13:06 -0700
Subject: [PATCH v3 5/5] mfd: regulator: max8998: BUCK1/2 voltage change
	with use of GPIOs
In-Reply-To: <1285590747-32404-6-git-send-email-l.majewski@samsung.com>
References: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
	<1285590747-32404-6-git-send-email-l.majewski@samsung.com>
Message-ID: <20100927161305.GH13754@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 27, 2010 at 02:32:27PM +0200, Lukasz Majewski wrote:

> - Predefined maximum voltages (as defined at platform data) are always
> available

What I was suggesting with this was that you use the upper end of the
voltage range that gets passed in with regulator_set_voltage() rather
than the platform data - that way the user doesn't need to know what
voltages the drivers are doing and the config can't drift out of sync
with the code.

However, this does look good overall so it seems best to apply this and
the previous patch now so:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
