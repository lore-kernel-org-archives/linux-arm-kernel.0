From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 18 Oct 2011 17:00:46 +0100
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111018115836.GC30703@S2100-06.ap.freescale.net>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-4-git-send-email-rnayak@ti.com>
	<20111016145536.GA29885@S2100-06.ap.freescale.net>
	<4E9BAC4D.3010402@ti.com>
	<20111018115836.GC30703@S2100-06.ap.freescale.net>
Message-ID: <20111018160046.GD28501@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 07:58:37PM +0800, Shawn Guo wrote:

> I understand that ideally device tree is supposed to describe pure
> hardware configurations.  But practically, when migrating a driver
> to device tree probe, we are trying to move the configurations
> described by platform_data into device tree to save the use of
> platform_data for device tree probe.  Then some of the configuration
> may not be so purely hardware related.  But I do not see this is a
> critical problem.

It's not just Linux-specific stuff, some of this is even specific to
what current Linux drivers can do - updating the kernel could mean a
different set of constraints.
