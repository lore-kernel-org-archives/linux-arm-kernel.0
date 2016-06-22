From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Jun 2016 11:53:32 +0200
Subject: [PATCH 1/2] cpufreq: exynos: use relaxed IO accesors
In-Reply-To: <1466587984-14105-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466587984-14105-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <3668897.kYSEflAvDO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 22, 2016 10:33:03 AM CEST Ben Dooks wrote:
> The use of __raw IO accesors is not endian safe and should be used
> sparingly. The relaxed variants should be as lightweight and also
> are endian safe.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 

Why not use the normal readl/writel() here instead of the relaxed version?

Either one should work here, but in general I'd recommend using the
non-relaxed version unless code is particularly performance sensitive.

The main argument for that is to not let people get used to using
_relaxed() all the time because it causes some very hard to debug
problems in the cases where you actually need the barriers.

	Arnd
