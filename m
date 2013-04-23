From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 22:14:18 +0200
Subject: [PATCH 14/21] staging: nvec: allow modular build
In-Reply-To: <1373204.GiWOFfjzyB@ax5200p>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <201304232141.04123.arnd@arndb.de> <1373204.GiWOFfjzyB@ax5200p>
Message-ID: <201304232214.18254.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 April 2013, Marc Dietrich wrote:
> It builds, but I haven't tried out it yet. At least the mfd children need to 
> unregister the event notifier I guess. Anyway, I have no time to test this 
> now, so I prefer to force =y for the dependencies for now.

Ah, so you can load it fine, but not safely unload it? In that case I think
it's better to leave it as tristate but remove the module_exit() function to
prevent unloading.

You'll have to change the module_platform_driver() back into a manual
module_init() function to register the driver, but that sounds like
the cleanest solution aside from fixing the notifier calls.

	Arnd
