From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 Oct 2013 17:09:44 +0100
Subject: Detect presence of LPAE when not running an LPAE kernel?
In-Reply-To: <1380870908.27765.24.camel@dagon.hellion.org.uk>
References: <1380829403.3804.56.camel@hastur.hellion.org.uk>
 <20131003200712.GG12758@n2100.arm.linux.org.uk>
 <1380870908.27765.24.camel@dagon.hellion.org.uk>
Message-ID: <20131004160944.GV24303@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 08:15:08AM +0100, Ian Campbell wrote:
> On Thu, 2013-10-03 at 21:07 +0100, Russell King - ARM Linux wrote:
> > On Thu, Oct 03, 2013 at 08:43:23PM +0100, Ian Campbell wrote:
> > > Is this possible?
> > > 
> > > The Features field of /proc/cpuinfo only appears to reflect the presence
> > > of LPAE if CONFIG_LPAE is actually on in the running kernel.
> > > 
> > > The reason I care is so that distro installers can ship a generic kernel
> > > but select LPAE for the running system when appropriate.
> > > 
> > > On x86 for example I would check /proc/cpuinfo:flags which contains the
> > > CPU features, regardless of whether they are currently enabled.
> > > 
> > > Is there any equivalent on ARM?
> > 
> > Perversely, LPAE in there has nothing to do with LPAE being used by the
> > kernel.  It's more to do with the presence of the double-word load/store
> > exclusive.
> 
> Ah, and I'm running 3.10 whereas this was added to 3.11-rc1.

Unless my memory is broken, if you see this HWCAP in a mainline kernel it
has always meant "the CPU you are running on is capable of LPAE". I don't
remember any dependency on CONFIG_LPAE.

> Should/do we expose the actual CPU LPAE capability somewhere?

That's the whole point of the HWCAP.

Are you sure your 3.10 hasn't got some extra magic?

Will
