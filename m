From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Dec 2014 18:51:55 +0000
Subject: OMAP 4430 SDP: rather sick with recent kernels
In-Reply-To: <20141217172333.GE23854@atomide.com>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
 <20141217172333.GE23854@atomide.com>
Message-ID: <20141217185155.GI11502@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 09:23:33AM -0800, Tony Lindgren wrote:
> Hi,
> 
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [141217 01:55]:
> > Tony,
> > 
> > As the IOMMU stuff was merged last night, which removed a really quite
> > horrid conflict resolution, I updated my nightly build tree from its
> > previous state last Thursday.
> > 
> > Now, SDP4430 seems to be really quite broken.
> 
> Sigh, things are just break left and right every merge window :(

Some of these things were present before the merge window, so they're
less of a concern.  The biggest problem though is the ABE ASoC stuff
exploding, which prevents my test system getting anywhere near mounting
its rootfs.

It's fine in the "combined" case, because we end up totally dead as
far as serial console goes, but the "omap4430" kernel boot test never
ends because the kernel doesn't stop spewing "rcu_sched stall" messages.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
