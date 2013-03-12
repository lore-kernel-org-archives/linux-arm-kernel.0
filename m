From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 19:10:54 +0000
Subject: [PATCH v2] ARM: tegra: expose chip ID and revision
In-Reply-To: <513F6E2C.1000101@wwwdotorg.org>
References: <1363089667-15737-1-git-send-email-dahuang@nvidia.com>
 <201303121259.18710.arnd@arndb.de> <513F6E2C.1000101@wwwdotorg.org>
Message-ID: <201303121910.55141.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 March 2013, Stephen Warren wrote:
> > You are dropping the soc_dev on the floor here by just returning.
> > 
> > The idea of the soc node is to have all on-soc components be children
> > of that node, so you should instead pass it into of_platform_populate
> > as the parent device.
> 
> Tegra DTs don't have a separate node for on-soc vs. off-soc components.
> Wouldn't passing soc_dev into of_platform_populate() make everything a
> child of this soc_dev; is that what we want?

Yes, we had long discussions about this when the soc infrastructure was
merged. Right now, everything is a child of /sys/devices/platform/,
basically saying that all devices are random stuff that cannot be
probed. Moving it to /sys/devices/soc0 would not make the hierarchy
any deeper but show much clearer which devices are part of the
soc, and which ones are added as anonymous platform devices by code
that does not use DT based probing. Ideally the second category is
empty.

	Arnd
