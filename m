From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Oct 2013 12:24:21 -0700
Subject: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
In-Reply-To: <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com>
 <52525642.8010307@ti.com> <20131007154103.GW8949@atomide.com>
 <20131007190322.GY8949@atomide.com>
 <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
 <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com>
Message-ID: <20131009192420.GE8313@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [131009 12:07]:
> Eh, one correction:
> 
> On Wed, 9 Oct 2013, Paul Walmsley wrote:
> 
> > We could easily wind up with kernels that won't boot at all when used 
> > with newer DT data.
> 
> This is a misstatement of the issue: the concern here is that newer 
> kernels may not boot at all with older DT data - which could easily be in 
> locked areas of the flash or firmware.

That's easy to avoid by allowing any combination of DT defined clocks,
loadable module clocks and /lib/firmware clocks depending on the use
case.

The older kernels have the clocks defined in DT, the newer kernels just
need to parse them.

Regards,

Tony
