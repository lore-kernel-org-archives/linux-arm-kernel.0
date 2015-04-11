From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Apr 2015 19:00:59 +0100
Subject: [PATCH] Ensure delay timer has sufficient accuracy for delays
In-Reply-To: <alpine.LFD.2.11.1504111339070.5619@knanqh.ubzr>
References: <20150411122056.GN12732@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1504111339070.5619@knanqh.ubzr>
Message-ID: <20150411180059.GO12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 11, 2015 at 01:42:35PM -0400, Nicolas Pitre wrote:
> On Sat, 11 Apr 2015, Russell King - ARM Linux wrote:
> 
> > We have recently had an example of someone wanting to use a 90kHz timer
> > for the software delay loop.
> > 
> > udelay() needs to have at least microsecond resolution to allow drivers
> > access to a delay mechanism with a reasonable chance of delaying the
> > period they requested within at least a 50% marging of error, especially
> > for small delays.
> > 
> > Discussion about the udelay() accuracy can be found at:
> > 	https://lkml.org/lkml/2011/1/9/37
> > 
> > Reject timers which are unable to supply this level of resolution.
> 
> Is there a platform where that would be the only available timer?
> Well, the code would use the loop based delay in that case.
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

See the thread "Guarantee udelay(N) spins at least N microseconds" where
we have someone trying to use a 90kHz counter for the delay loop, where
there's complaints that delays are (a) not accurate and (b) can equate
to no delay at all due to the low resolution of the counter, with all
sorts of rediculous arguments put forward.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
