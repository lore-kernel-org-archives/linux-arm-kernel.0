From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Nov 2009 17:33:08 +0000
Subject: Can anyone help test Cortex A9 patches?
In-Reply-To: <1258651486.24487.55.camel@pc1117.cambridge.arm.com>
References: <20091119090328.GC13376@n2100.arm.linux.org.uk>
	<1258651486.24487.55.camel@pc1117.cambridge.arm.com>
Message-ID: <20091119173308.GC22232@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 05:24:46PM +0000, Catalin Marinas wrote:
> On Thu, 2009-11-19 at 09:03 +0000, Russell King - ARM Linux wrote:
> > I need help testing Cortex A9 patches.  What I need is someone with a
> > fairly fully fledged Cortex A9 platform with the ability to build and
> > test recent kernels - and therefore be able to test my patches without
> > modification.
> > 
> > Specifically, I'm looking for someone who can reproduce data corruption
> > on DMA transfers from devices caused by Cortex A9's speculative prefetching
> > 
> > Unfortunately, I have no way to reproduce this problem here (I have no
> > Cortex A9 hardware), and as such I can't test the fixes.
> 
> I can get access to a PBX-A9 board but there is no DMA support on it, so
> not able to reproduce the problem.
> 
> What's the background to this? Has anyone reported issues?

Well, I had a fast response from people this morning, and the patch has
been successfully tested against a recent kernel.  So problem mostly
solved.

Essentially corruption caused by speculative prefetches from buffers while
they are mapped for DMA.  You were sent an email late last month about
the problem:

http://lists.arm.linux.org.uk/lurker/message/20091031.131319.18796aa1.en.html

Unfortunately, the reporter seems to have taken the subsequent messages
off the list.  Morevoer, the original reporter said the patch didn't help,
however since he applied it to an older kernel and got rejects, I'm going
to dismiss that.  I can find nothing wrong with my patch which would mean
his original problem would not be fixed.
