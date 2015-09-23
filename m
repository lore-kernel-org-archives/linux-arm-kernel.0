From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Sep 2015 10:26:50 +0100
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56026F0B.2000701@free.fr>
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
 <56016780.5080104@free.fr> <144297172.JfjI0hNJ9J@wuerfel>
 <5601799C.20701@free.fr>
 <20150922162947.GC21084@n2100.arm.linux.org.uk>
 <56026795.3090403@free.fr>
 <20150923091342.GH21084@n2100.arm.linux.org.uk>
 <56026F0B.2000701@free.fr>
Message-ID: <20150923092650.GJ21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 11:21:15AM +0200, Mason wrote:
> On 23/09/2015 11:13, Russell King - ARM Linux wrote:
> > On Wed, Sep 23, 2015 at 10:49:25AM +0200, Mason wrote:
> >> In my platform Kconfig, something along the lines of
> >>
> >> config ARM_L1_CACHE_SHIFT
> >> 	int
> >> 	default 5 if !ARCH_MULTIPLATFORM
> > 
> > How would that be useful to you?  Arnd is saying that you will always
> > need ARCH_MULTIPLATFORM selected to build your platform.
> > 
> > This symbol doesn't automatically turn off just because you only have
> > one platform enabled.
> 
> I must be missing the big picture for ARCH_MULTIPLATFORM.
> 
> I thought modern ports /had/ to support it, but that it could
> be disabled locally to build a single platform kernel?

ARCH_MULTIPLATFORM is purely a Kconfig construct to allow separation of
platforms which support being built together, and those which don't.
It provides a certain basic level of support when enabled (such as DT,
CCF, etc.)  It remains enabled even if you only want to build for one
platform in the multi-platform group.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
