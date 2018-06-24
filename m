From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 24 Jun 2018 02:21:04 +0200 (CEST)
Subject: [PATCH 3/8] arm: time: Remove the persistent clock support for
 ARM architecture
In-Reply-To: <ec57a4f5d7ba300540b99236e6eef1b551b152dc.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
 <ec57a4f5d7ba300540b99236e6eef1b551b152dc.1528878545.git.baolin.wang@linaro.org>
Message-ID: <alpine.DEB.2.21.1806240215310.8650@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Jun 2018, Baolin Wang wrote:

> We have introduced the persistent clock framework to support the OS time
> compensating from persistent clock, and we will convert all drivers to
> use common persistent clock framework instead of the persistent clock
> support used only for the ARM architecture. So we can remove these code
> with converting the Omap 32k counter and tegra20 timer.

Why did I look at that in the first place? But as I did, I just have to
say, it's just consistent trainwreck engineering. Remove working code first
and then add new one.

Hell NO! This is not how it works. We add new infrastructure - if required
with some extra temporary helpers - while keeping the existing
functionality intact. Then we convert the users of the old infrastructure
over and when the last user is gone, we remove that including all temporary
helpers.

That's not something fundamentally new. It's documented all over the place.

Thanks,

	tglx
