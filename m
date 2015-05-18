From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 18 May 2015 01:19:18 -0400 (EDT)
Subject: [linux-sunxi] [RFC 0/7] ARM: sun9i: SMP support with Multi-Cluster
 Power Management
In-Reply-To: <20150517143816.GJ4004@lukather>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
 <1431770926.5748.41.camel@hellion.org.uk> <20150517143816.GJ4004@lukather>
Message-ID: <alpine.LFD.2.11.1505180112570.4843@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 17 May 2015, Maxime Ripard wrote:

> Hi Ian,
> 
> On Sat, May 16, 2015 at 11:08:46AM +0100, Ian Campbell wrote:
> > On Thu, 2015-05-14 at 14:10 +0800, Chen-Yu Tsai wrote:
> > > This is my attempt to support SMP and CPU hot plugging on the Allwinner
> > > A80 SoC. The A80 is a big.Little processor with 2 clusters of 4x Cortex-A7
> > > and 4x Cortex-A15 cores.
> > 
> > I thought there was a preference these days to support this sort of
> > thing via support PSCI in the firmware, which allows for other things
> > such as non-secure-world etc.
> 
> Yes, it is the preferred way. Meaning that if someone wants to do that
> work, he's very much welcome and encouraged to do so. But if no one's
> doing it, then we still have to have a way to bringup the secondary
> CPUs.

And doing so in the kernel (at least initially) is simpler, and so much 
easier to fix when it is broken.  We've seen a few systems already where 
power management is crippled because no one is able/allowed/willing to 
fix the broken firmware.


Nicolas
