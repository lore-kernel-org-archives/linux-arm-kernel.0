From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 22 Mar 2011 16:52:48 +0000
Subject: [PATCH v3 1/7] mfd: add pruss mfd driver.
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C47D5EE@dbde02.ent.ti.com>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<1299592667-21367-2-git-send-email-subhasish@mistralsolutions.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C3B85A5@dbde02.ent.ti.com>
	<20110318123917.GC27129@sirena.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024C47D5EE@dbde02.ent.ti.com>
Message-ID: <20110322165248.GF22583@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2011 at 03:05:07PM +0530, Nori, Sekhar wrote:
> On Fri, Mar 18, 2011 at 18:09:17, Mark Brown wrote:

> > ...unfortunately conflicts with this - currently all clock API
> > implementations are unique to the platform and there's no way of adding
> > clocks that works over multiple platforms.

> Hmm, I guess I have a limited view of this. We do have drivers which
> use clock API and work across OMAP and DaVinci series of ARM SoCs.
> The clock implementation in this case is under mach-omap and mach-davinci
> respectively.

It's mostly fine from the point of view of using clocks, it's if you're
trying to provide a clock that there's no API you can rely on - the
clock API itself only includes the user side and every platform gets to
provide its own implementation.
