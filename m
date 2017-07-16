From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 16 Jul 2017 20:24:58 +0200
Subject: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
In-Reply-To: <20170716133832.mnuaie4jnlwu6dwj@piout.net>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <1703157.S2GHVxrQk4@aspire.rjw.lan>
 <e680f86a-88db-8a53-dca6-a79d120d480b@gmail.com>
 <3675920.H2f5xgTCgu@aspire.rjw.lan>
 <20170716133832.mnuaie4jnlwu6dwj@piout.net>
Message-ID: <20170716182457.GC14461@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > There still will be a concern regarding drivers that care about differences between
> > PM_SUSPEND_MEM and PM_SUSPEND_STANDBY, because those differences are
> > platform-dependent, but let's defer addressing this until we have a driver
> > that needs to run on different platforms with different definitions for those
> > things.
> > 
> 
> We already have the case for drivers/net/ethernet/cadence/ and
> drivers/net/can/m_can/ and many of the at91 drivers. Depending on the
> specific SoC they run on, PM_SUSPEND_MEM may or may not cut VDDcore or
> may or may not change the peripheral clock.

Please please introduce will_vddcore_be_cut_down() or similar helper,
so that we have one place to fix..

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170716/382ea0f6/attachment.sig>
