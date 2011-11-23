From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Nov 2011 10:57:01 +0000
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
 selection
In-Reply-To: <20111122230030.GB3005@opensource.wolfsonmicro.com>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
 <20111122164707.GJ6624@sirena.org.uk>
 <20111122202425.GD9581@n2100.arm.linux.org.uk>
 <1484610.g1p0X99tcV@wuerfel>
 <20111122230030.GB3005@opensource.wolfsonmicro.com>
Message-ID: <20111123105701.GE25848@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 11:00:31PM +0000, Mark Brown wrote:
> On Tue, Nov 22, 2011 at 10:19:53PM +0100, Arnd Bergmann wrote:
> 
> > and then selecting DEBUG_LL_LEGACY from all platforms that do their own
> > thing. That would avoid the possible randconfig errors.
> 
> Your fix seems good to me, and avoids causing hassle for randconfig
> folks, though Russell's will be more likely to encourage people to
> convert I guess.

Although Russell's approach is a build breaker for those platforms that have
not yet made the switch, that does provide an incentive for the platform
maintainers to update their code. If we settle for a legacy solution it will
probably sit around forever.

Given that we're now past -rc2, it might be best to wait until the next
merge window to introduce the #error logic, so the LEGACY solution could be
a stopgap for 3.2.

Will
