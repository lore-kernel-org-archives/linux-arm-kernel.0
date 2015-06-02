From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Jun 2015 00:52:39 +0100
Subject: [PATCH] ARM: socfpga: add smp_ops.cpu_kill to make kexec/kdump
 available
In-Reply-To: <556E3F03.5040008@hitachi.com>
References: <20150529053844.31162.43927.stgit@arietta>
 <20150529083339.GG2067@n2100.arm.linux.org.uk>
 <XNM1$3$0$0$$3$3$3$A$0000051U556d3fe3@hitachi.com>
 <20150602083804.GX2067@n2100.arm.linux.org.uk>
 <556E3F03.5040008@hitachi.com>
Message-ID: <20150602235239.GB7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 03, 2015 at 08:40:51AM +0900, Hiraku Toyooka wrote:
> Hello, Russell,
> 
> On 2015/06/02 17:38, Russell King - ARM Linux wrote:
> > I wasn't thinking of SPIs and PPIs, but SGIs - the IPI interrupts coming
> > from the boot CPU.
> 
> All tasks in a CPU going offline are migrated to other CPUs(finally
> CPU0) and the rq is marked with offline before the CPU entering WFI
> loop. So IPI is not sent to the secondary CPU.
> 
> > If you have a way to reset CPU0, why are you not using this for hotplug
> > when a CPU is hot-unplugged?
> 
> I think you mean "way to reset CPU1". If so, the reason is an increase
> in power consumption in usual hotplug. This is discussed before between
> Alan Tull and you. (https://lkml.org/lkml/2014/9/25/37)

Please put a comment in your hotplug code describing this, so I'm
not likely to ask again (and I don't have to remember that I've
asked the question.)  Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
