From: horms@verge.net.au (Simon Horman)
Date: Fri, 21 Oct 2011 17:59:58 +0900
Subject: Possible regression in kexec on ARM ARMv6 and ARMv7 cores
In-Reply-To: <20111021084641.GA30168@mudshark.cambridge.arm.com>
References: <20111020042444.GA20260@verge.net.au>
	<20111020070105.GA28548@mudshark.cambridge.arm.com>
	<20111020080823.GA2716@verge.net.au>
	<20111021083426.GA16088@verge.net.au>
	<20111021084641.GA30168@mudshark.cambridge.arm.com>
Message-ID: <20111021085958.GC21850@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2011 at 09:46:41AM +0100, Will Deacon wrote:
> On Fri, Oct 21, 2011 at 09:34:26AM +0100, Simon Horman wrote:
> > I have tested the kexec/mmu-off branch of your tree on the UP board
> > I mentioned above and kexec works :)
> 
> Hurrah! Thanks for giving it a spin.
> 
> > > You mention UP in particular, which I will test.
> > > Do you have any thoughts on SMP?
> 
> Yes. Currently [i.e. on my branch above] you can do SMP kexec using the CPU
> hotplug platform_cpu_kill callback to take down the CPUs in some
> platform-specific manner.

Thanks, I will take a look into it.

> The more difficult case is when you want to offline the secondary CPUs into
> a pen and then boot them in the new kernel. I did get some of this working,
> but there are outstanding issues with whether the pen should be at a fixed
> location or not. If not, then we need a way to tell the new kernel where it
> is, which may involve updating the DT blob...

Is the implication that the (working) callback method does not
give the second kernel any secondary CPUs?
