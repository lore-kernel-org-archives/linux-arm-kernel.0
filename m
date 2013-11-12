From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Nov 2013 14:44:31 +0000
Subject: Physical memory start contraints in the Linux kernel  (Was:
 Re: Xen osstest on Calxeda midway progress (Was: Re: [Xen-devel]
 [xen-unstable test] 21486: tolerable FAIL - PUSHED))
In-Reply-To: <1384267135.10204.18.camel@kazak.uk.xensource.com>
References: <1383731526.26213.25.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311061111580.26077@kaball.uk.xensource.com>
 <1383736784.26213.72.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311061938080.26077@kaball.uk.xensource.com>
 <1383822868.26213.181.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311111825090.26077@kaball.uk.xensource.com>
 <1384250005.1883.35.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311121212240.26077@kaball.uk.xensource.com>
 <20131112132001.GJ16735@n2100.arm.linux.org.uk>
 <1384267135.10204.18.camel@kazak.uk.xensource.com>
Message-ID: <20131112144431.GM16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 02:38:55PM +0000, Ian Campbell wrote:
> On Tue, 2013-11-12 at 13:20 +0000, Russell King - ARM Linux wrote:
> > If there's any other issues with multiplatform, then yes, we want to hear
> > about them.
> 
> I think some of the issues we've been seeing were with non-MP kernels.
> Specifically they were on Arndale, which appeared to be unhappy with RAM
> being much higher than the normal base address. I believe Arndale/Exynos
> is currently not (fully?) MP? Or maybe wasn't when this came up?

I'm not aware of there ever being any SMP/UP constraints on memory in the
non-platform specific code.

It's possible that some of the platform specific SMP bringup code relies
on physical memory at certain addresses (eg, due to restrictions in their
boot protocol for starting secondary CPUs) but running a non-MP kernel
wouldn't include that code so shouldn't be affected by this.
