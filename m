From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Apr 2012 22:59:03 +0100
Subject: [PATCHv3 1/4] ARM: tegra: Add AHB driver
In-Reply-To: <4F99A740.3080407@wwwdotorg.org>
References: <1335352072-4001-1-git-send-email-hdoyu@nvidia.com>
 <4F99A740.3080407@wwwdotorg.org>
Message-ID: <20120426215903.GH24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 01:51:28PM -0600, Stephen Warren wrote:
> On 04/25/2012 05:07 AM, Hiroshi DOYU wrote:
> > The AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
> > High-performance Bus (AHB) architecture.
> > 
> > The AHB Arbiter controls AHB bus master arbitration. This effectively
> > forms a second level of arbitration for access to the memory
> > controller through the AHB Slave Memory device. The AHB pre-fetch
> > logic can be configured to enhance performance for devices doing
> > sequential access. Each AHB master is assigned to either the high or
> > low priority bin. Both Tegra20/30 have this AHB bus.
> > 
> > Some of configuration param could be passed from DT too.
> 
> I think this code looks reasonable. I'd like to see an ack from Russell,
> Arnd, and Olof on the final location of the files though.

Well, the big question which needs answering is whether this AHB software
interface is something specific to Tegra or whether it really is something
generic.  There's been some hints in the previous thread that it's
specific to Tegra, so it may not after all make sense for it to be a
generic driver.

However, we _have_ decided "no more drivers under arch/arm".  So I really
don't want to see "struct xxx_driver" appearing in any code under that
subdirectory or one of its decendents.  I don't have much more to say
about location than that.
