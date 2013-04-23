From: marvin24@gmx.de (Marc Dietrich)
Date: Tue, 23 Apr 2013 22:21:03 +0200
Subject: [PATCH 14/21] staging: nvec: allow modular build
In-Reply-To: <201304232214.18254.arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1373204.GiWOFfjzyB@ax5200p> <201304232214.18254.arnd@arndb.de>
Message-ID: <11391915.IGaQsBJu0i@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 April 2013 22:14:18 Arnd Bergmann wrote:
> On Tuesday 23 April 2013, Marc Dietrich wrote:
> > It builds, but I haven't tried out it yet. At least the mfd children need
> > to unregister the event notifier I guess. Anyway, I have no time to test
> > this now, so I prefer to force =y for the dependencies for now.
> 
> Ah, so you can load it fine, but not safely unload it? In that case I think
> it's better to leave it as tristate but remove the module_exit() function to
> prevent unloading.
> 
> You'll have to change the module_platform_driver() back into a manual
> module_init() function to register the driver, but that sounds like
> the cleanest solution aside from fixing the notifier calls.

ok, I'll look into it - maybe I can also fix unloading.

Thanks!

Marc
