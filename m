From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Sep 2016 22:35:31 +0200
Subject: [GIT PULL] i.MX legacy board changes for 4.9
In-Reply-To: <20160921061613.GI3744@tiger>
References: <20160921061613.GI3744@tiger>
Message-ID: <16516723.rht87947HL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 21, 2016 2:16:13 PM CEST Shawn Guo wrote:
> I know this is late for 4.9 merge window, but the patch series fixes a
> regression for i.MX legacy board support on linux-next [1].  So please
> pull it for 4.9 merge window.  Otherwise, we will need to get them in
> during 4.9-rc cycles.

No worries, there is no "late" for regression fixes.

> ----------------------------------------------------------------
> i.MX legacy board file changes for 4.9:
> 
> It includes a patch series that moves registrations and initializations
> of all peripherals which are GPIO line consumers for all legacy boards
> from .init_machine to .init_late init level. This is needed to
> proactively prevent boot time issues on the legacy boards due to the
> deprioritized init level of the GPIO controller driver (set lower than
> IOMUX controller driver init level), which is shared among all i.MX
> SoCs.

Pulled into next/soc, thanks!

	Arnd
