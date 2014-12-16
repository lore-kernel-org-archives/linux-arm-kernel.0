From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Dec 2014 20:23:01 +0000
Subject: regression: Clock changes in next-20141205 break at least omap4
In-Reply-To: <54908F8D.2020202@nvidia.com>
References: <5481F79D.4010504@codeaurora.org>
 <20141205183849.GB30437@atomide.com>
 <20141212194238.20398.33333@quantum>
 <alpine.DEB.2.02.1412122310570.29716@utopia.booyaka.com>
 <20141215220224.20398.98259@quantum> <548F7B02.1090009@nvidia.com>
 <20141216003834.GC23854@atomide.com> <548F8B70.2060803@nvidia.com>
 <5490816E.7060706@codeaurora.org> <54908F8D.2020202@nvidia.com>
Message-ID: <20141216202301.GF11502@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 01:01:17PM -0700, Paul Walmsley wrote:
> So the reference clock and functional clock are (usually) required by the
> PLL to operate, and should therefore be required by the PLL clock driver
> code in the kernel; but one could claim that they aren't technically parent
> clocks of the PLL in a clock tree sense, since the downstream output clock
> isn't directly derived from either of those clocks.

The reference clock is the parent clock for a PLL, and the output clock
is a derivative of the reference clock.  The PLL maths show that very
clearly.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
