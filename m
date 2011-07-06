From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 23:55:50 +0100
Subject: [PATCHv2] arm: platsmp: Allow secondary cpu hotplug with maxcpus=1
In-Reply-To: <1309886957-7548-1-git-send-email-sboyd@codeaurora.org>
References: <1309886957-7548-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20110706225550.GA28957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 10:29:17AM -0700, Stephen Boyd wrote:
> If an ARM system has multiple cpus in the same socket and the
> kernel is booted with maxcpus=1, secondary cpus are possible but
> not present due to how platform_smp_prepare_cpus() is called.
> Since most typical ARM processors don't actually support physical
> hotplug, initialize the present map to be equal to the possible
> map in generic ARM SMP code. Also, always call
> platform_smp_prepare_cpus() as long as max_cpus is non-zero (0
> means no SMP) to allow platform code to do any SMP setup.
> 
> After applying this patch it's possible to boot an ARM system
> with maxcpus=1 on the command line and then hotplug in secondary
> cpus via sysfs. This is more in line with how x86 does things.

Ok - how about putting this in the patch system?

Thanks.
