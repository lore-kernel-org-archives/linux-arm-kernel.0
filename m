From: ijc@hellion.org.uk (Ian Campbell)
Date: Fri, 04 Oct 2013 17:23:22 +0100
Subject: Detect presence of LPAE when not running an LPAE kernel?
In-Reply-To: <20131004160944.GV24303@mudshark.cambridge.arm.com>
References: <1380829403.3804.56.camel@hastur.hellion.org.uk>
 <20131003200712.GG12758@n2100.arm.linux.org.uk>
 <1380870908.27765.24.camel@dagon.hellion.org.uk>
 <20131004160944.GV24303@mudshark.cambridge.arm.com>
Message-ID: <1380903802.21562.46.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-10-04 at 17:09 +0100, Will Deacon wrote:
> On Fri, Oct 04, 2013 at 08:15:08AM +0100, Ian Campbell wrote:
> > On Thu, 2013-10-03 at 21:07 +0100, Russell King - ARM Linux wrote:
> > > On Thu, Oct 03, 2013 at 08:43:23PM +0100, Ian Campbell wrote:
> > > > Is this possible?
> > > > 
> > > > The Features field of /proc/cpuinfo only appears to reflect the presence
> > > > of LPAE if CONFIG_LPAE is actually on in the running kernel.
> > > > 
> > > > The reason I care is so that distro installers can ship a generic kernel
> > > > but select LPAE for the running system when appropriate.
> > > > 
> > > > On x86 for example I would check /proc/cpuinfo:flags which contains the
> > > > CPU features, regardless of whether they are currently enabled.
> > > > 
> > > > Is there any equivalent on ARM?
> > > 
> > > Perversely, LPAE in there has nothing to do with LPAE being used by the
> > > kernel.  It's more to do with the presence of the double-word load/store
> > > exclusive.
> > 
> > Ah, and I'm running 3.10 whereas this was added to 3.11-rc1.
> 
> Unless my memory is broken, if you see this HWCAP in a mainline kernel it
> has always meant "the CPU you are running on is capable of LPAE". I don't
> remember any dependency on CONFIG_LPAE.

I was just confused by it not appearing in 3.10 and assumed it was a
dependency on CONFIG_LPAE when in reality the hwcap just wasn't added
until 3.11-rc1.

> > Should/do we expose the actual CPU LPAE capability somewhere?
> 
> That's the whole point of the HWCAP.

Russell was saying it actually related to the presence of strd/ldrd, how
tightly is that tied to the presence of LPAE in theory? In practise it
seems closely related...

> Are you sure your 3.10 hasn't got some extra magic?

Yep ;-)

Ian.
