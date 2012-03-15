From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 15:52:54 +0000
Subject: [PATCH v9] mfd: Add anatop mfd driver
In-Reply-To: <20120315120948.GG3138@opensource.wolfsonmicro.com>
References: <1331797421-23731-1-git-send-email-paul.liu@linaro.org>
 <201203150907.29895.arnd@arndb.de>
 <20120315120948.GG3138@opensource.wolfsonmicro.com>
Message-ID: <201203151552.54617.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Mark Brown wrote:
> There were some other mutterings about using regmap for memory mapped
> devices, mostly from the point of view of building framework features
> like this on top of it.  regmap currently makes some assumptions that
> the I/O is going to be slow so approximately any amount of CPU time can
> usefully be spent on avoiding I/O but we can probably do something about
> that.  It also uses mutexes to lock I/O which might not be the most
> sensible thing for memory mapped devices, but again that's solveable.
> Right now there's no memory mapping support but there's no reason that
> can't be added.
> 
> In short, it does seem sensible to want to have some support for this
> for devices that use appropriate idioms.

Ok, I see. 

I guess there is no reason to change anything in Paul's patch now, but
we can keep this in mind if we see a lot of similar drivers in the future.

Thanks,

	Arnd
