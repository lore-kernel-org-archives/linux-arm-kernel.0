From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Mar 2014 22:35:24 -0600
Subject: CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS and bcm2835_defconfig
In-Reply-To: <alpine.DEB.2.10.1403101717050.31525@vincent-weaver-1.um.maine.edu>
References: <alpine.DEB.2.10.1403101717050.31525@vincent-weaver-1.um.maine.edu>
Message-ID: <531FE40C.1060709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2014 03:21 PM, Vince Weaver wrote:
> Hello
> 
> I buit the current
> 	git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git
> kernel on a Raspberry Pi.
> 
> I used 
> 	make bcm2835_defconfig
> 	make zImage
> but the results zImage hung at boot.
> 
> It turned out that for some reason 
> 	CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> and
> 	CONFIG_ARCH_USE_BUILTIN_BSWAP=y

Hmm. I thought that ARMv6 didn't have efficient unaligned accesses, but
I suppose it must; ARM selects HAVE_EFFICIENT_UNALIGNED_ACCESS for
v6/v6k/v7. BUILTIN_BSWAP seems innocuous. Can you verify which of those
two options actually causes problems for you?

I'm not sure why either of these options would cause any trouble.
Perhaps Will might have some suggestions, since he authored the code
that selects HAVE_EFFICIENT_UNALIGNED_ACCESS, or Kim since he authored
the code that selects ARCH_USE_BUILTIN_BSWAP. Perhaps there are
compiler-version-specific bugs, or the RPi's native toolchain has issues?
