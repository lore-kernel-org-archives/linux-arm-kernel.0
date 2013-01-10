From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 10 Jan 2013 00:04:21 -0500 (EST)
Subject: [PATCH 00/16] big.LITTLE low-level CPU and cluster power
 management
In-Reply-To: <50EE0F64.8020009@gmail.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <50EE0F64.8020009@gmail.com>
Message-ID: <alpine.LFD.2.02.1301092353500.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jan 2013, Rob Herring wrote:

> On 01/09/2013 06:20 PM, Nicolas Pitre wrote:
> > This is the initial public posting of the initial support for big.LITTLE.
> > Included here is the code required to safely power up and down CPUs in a
> > b.L system, whether this is via CPU hotplug, a cpuidle driver or the
> > Linaro b.L in-kernel switcher[*] on top of this.  Only  SMP secondary
> > boot and CPU hotplug support is included at this time.  Getting to this
> > point already represents a significcant chunk of code as illustrated by
> > the diffstat below.
> > 
> > This work was presented at Linaro Connect in Copenhagen by Dave Martin and
> > myself.  The presentation slides are available here:
> > 
> > http://www.linaro.org/documents/download/f3569407bb1fb8bde0d6da80e285b832508f92f57223c
> > 
> > The code is now stable on both Fast Models as well as Virtual Express TC2
> > and ready for public review.
> > 
> > Platform support is included for Fast Models implementing the
> > Cortex-A15x4-A7x4 and Cortex-A15x1-A7x1 configurations.  To allow
> > successful compilation, I also included a preliminary version of the
> > CCI400 driver from Lorenzo Pieralisi.
> > 
> > Support for actual hardware such as Vexpress TC2 should come later,
> > once the basic infrastructure from this series is merged.  A few DT
> > bindings are used but not yet documented.
> > 
> > This series is made of the following parts:
> > 
> > Low-level support code:
> > [PATCH 01/16] ARM: b.L: secondary kernel entry code
> > [PATCH 02/16] ARM: b.L: introduce the CPU/cluster power API
> > [PATCH 03/16] ARM: b.L: introduce helpers for platform coherency
> > [PATCH 04/16] ARM: b.L: Add baremetal voting mutexes
> > [PATCH 05/16] ARM: bL_head: vlock-based first man election
> 
> After a quick scan, I have a basic question. How are any of these
> specific to big.LITTLE? Isn't all this just general multi-cluster support?

It is.  However, b.L is what brought the need for this multi-cluster 
support, and being first it gave the name.

I've been pondering about naming this code differently so not to imply 
b.L but I couldn't come up with a good name/prefix.  The bL_ prefix is 
really hard to beat!  So I decided to put it off until there is actually 
some non b.L users for this code, at which point we can trivially rename 
it.


Nicolas
