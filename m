From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Jun 2016 21:28:54 -0700
Subject: [PATCH] ARM: Keystone: Introduce Kconfig option to compile in
 typical Keystone features
In-Reply-To: <574F6674.3010100@ti.com>
References: <1464816714-3900-1-git-send-email-nm@ti.com>
 <3593753.UuDg5ybrvm@wuerfel> <574F6674.3010100@ti.com>
Message-ID: <20160607042853.GA22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [160601 15:51]:
> On 06/01/2016 05:31 PM, Arnd Bergmann wrote:
> > On Wednesday, June 1, 2016 4:31:54 PM CEST Nishanth Menon wrote:
> >>
> >> Hence the "KEYSTONE_TYPICAL" option is designed similar to commit 8d9166b519fd
> >> ("omap2/3/4: Add Kconfig option to compile in typical omap features")
> >> that can be enabled for most boards keystone platforms
> >> without needing to rediscover these in defconfig all over again -
> >> examples include multi_v7_defconfig base and optimizations done on top
> >> of them for keystone platform.
> > 
> > I'd rather remove the option for OMAP as well, it doesn't really fit in with
> > how we do things for other platforms, and selecting a lot of other Kconfig
> > symbols tends to cause circular dependencies.
> 
> Hmm, fair enough -> adding Tony as well if he sees an problem with
> dropping ARCH_OMAP2PLUS_TYPICAL.

Yes there's a problem. Removing that is going to make all the custom
.config files unbootable almost certainly. Just search around on
issues related to not having REGULATOR_FIXED_VOLTAGE selected.

I agree we should not force select things though. And the I2C selection
at least is wrong, we can have PMICs that are not on I2C bus.

Anybody got better ideas what we should do to make the configuration
options more intuitive?

Regards,

Tony
