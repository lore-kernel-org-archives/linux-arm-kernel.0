From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Jul 2012 08:05:03 +0000
Subject: [PATCH 2 2/4] net ethernet introduce mac_la_ap helper
In-Reply-To: <4FF27751.9050004@linaro.org>
References: <20120702063545.26782.98908.stgit@build.warmcat.com>
 <201207021612.57028.arnd@arndb.de> <4FF27751.9050004@linaro.org>
Message-ID: <201207030805.04160.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 July 2012, Andy Green wrote:
> > I think it would be simpler to register the notifier from an
> > initcall and drop the mac_la_ap_started variable.
> 
> That was my first approach, to structure it as a real driver.  I had 
> tried a few likely-looking initcall levels but the init of the helper 
> was coming after the init of the network code.
> 
> I found this time that core_initcall works, so I used that, dropped the 
> flag.  But isn't it a bit tricky with these to know if the prerequisite 
> you're trying to ensure is already initialized might not actually be at 
> the same initcall level and you're working by accident?

Well, you would only need to ensure that it's called before any of the
network devices are added, which should all happen very late in the
boot cycle compared to the platform init code.

I think core_initcall is fine here.

	Arnd
