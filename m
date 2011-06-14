From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Jun 2011 05:41:38 -0700
Subject: [PATCH] OMAP1: PM: register notifiers with generic clock ops
	even when !PM_RUNTIME
In-Reply-To: <1307491502-28883-1-git-send-email-khilman@ti.com>
References: <1307491502-28883-1-git-send-email-khilman@ti.com>
Message-ID: <20110614124137.GD23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110607 17:00]:
> When runtime PM is disabled, device clocks need to be enabled on
> device add and disabled on device remove.  This currently is not
> happening because in the !PM_RUNTIME case, no notifiers are registered
> for OMAP1 devices.
> 
> Fix this by ensuring notifiers are registered, even in the !PM_RUNTIME case.
> 
> Reported-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Tony, this fix should go in for v3.0-rc as well.

Adding to devel-fixes.

Tony
