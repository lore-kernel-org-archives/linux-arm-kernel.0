From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 14 Sep 2011 17:10:20 +0100
Subject: [PATCH 2/6] ARM: zImage: Allow the appending of a device tree
	binary
In-Reply-To: <alpine.LFD.2.00.1109141056150.20358@xanadu.home>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
	<1315978906-15829-3-git-send-email-nico@fluxnic.net>
	<20110914133244.GE2104@arm.com>
	<alpine.LFD.2.00.1109140957000.20358@xanadu.home>
	<20110914142030.GF2104@arm.com>
	<alpine.LFD.2.00.1109141056150.20358@xanadu.home>
Message-ID: <20110914161020.GH2104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 11:10:44AM -0400, Nicolas Pitre wrote:
> On Wed, 14 Sep 2011, Dave Martin wrote:
> 
> > On Wed, Sep 14, 2011 at 10:04:28AM -0400, Nicolas Pitre wrote:
> > > On Wed, 14 Sep 2011, Dave Martin wrote:
> > > 

[...]

> > > > Do we worry that garbage in memory after the zImage might match this
> > > > magic number?
> > > > 
> > > > For example, if an ordinary userspace program allocates a huge number
> > > > of pages and fills them with bogus device tree headers, is there a chance
> > > > that the those headers could remain in memory across a reboot?
> > > 
> > > In theory this _could_ be possible.  However I don't expect this feature 
> > > to be enabled if you are not going to actually use it, especially in a 
> > > production setup.  If you are not appending a DTB to your kernel then 
> > > there is simply no point keeping this config option set (normally you 
> > > should use this option only because you have no other choices).
> > 
> > That seems reasonable.
> > 
> > Should we document this recommendation, in the Kconfig help or
> > Documentation/?
> 
> I'll add some scary wording to the help text, and make it depend on 
> EXPERIMENTAL as well.  I prefer not to impose some expectations on the 
> zImage layout for this even if not in use, like being stuck with an 
> offset that we'll always have to guard against corruption due to people 
> blindly scripting the zImage poking you suggested even when it is not 
> needed.
> 
> People will find ways to screw it up if they really want to anyway.  So 
> I'd lean towards keeping this simple and not create any legacy around 
> this hopefully temporary accommodation feature.

Yeah, sure -- I think documentating it is enough for now.

And I agree we don't really want to reinvent the rdev nastiness for zImages...

Cheers
---Dave
