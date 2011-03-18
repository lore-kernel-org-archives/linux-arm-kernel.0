From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 18 Mar 2011 12:39:17 +0000
Subject: [PATCH v3 1/7] mfd: add pruss mfd driver.
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C3B85A5@dbde02.ent.ti.com>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<1299592667-21367-2-git-send-email-subhasish@mistralsolutions.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C3B85A5@dbde02.ent.ti.com>
Message-ID: <20110318123917.GC27129@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2011 at 05:29:39PM +0530, Nori, Sekhar wrote:

> PRUSS as an IP is not really tied to the DA8xx SoC architecture.
> So, can you please name the files ti-pruss* or even just pruss if
> MFD folks are okay with it?

This...

> > +EXPORT_SYMBOL(pruss_get_clk_freq);

> This looks strange. Why do we need this? There
> is clk_get_rate() API in the kernel would would
> seem more suitable.

...unfortunately conflicts with this - currently all clock API
implementations are unique to the platform and there's no way of adding
clocks that works over multiple platforms.
