From: tixy@yxit.co.uk (Tixy)
Date: Tue, 06 Dec 2011 20:22:47 +0000
Subject: [RFC][PATCH] ARM: kirkwood: Remove eSATA SheevaPlug board support
In-Reply-To: <alpine.LFD.2.02.1112061442430.2357@xanadu.home>
References: <1322737480.9622.5.camel@phoenix>
 <1322912383.2378.79.camel@computer2>
 <alpine.LFD.2.02.1112031247230.2357@xanadu.home>
 <1323155228.2237.10.camel@computer2>
 <alpine.LFD.2.02.1112061442430.2357@xanadu.home>
Message-ID: <1323202967.3019.12.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-12-06 at 14:45 -0500, Nicolas Pitre wrote:
> On Tue, 6 Dec 2011, Tixy wrote:
> 
> > On Sat, 2011-12-03 at 13:00 -0500, Nicolas Pitre wrote:
> > > On Sat, 3 Dec 2011, Tixy wrote:
> > > > [PATCH] Fix machine_is_xxx() naming for eSata SheevaPlug and QNAP TS-209
> > > > 
> > > > The eSata SheevaPlug and QNAP TS-209 devices were removed from
> > > > mach-types due to naming mismatches between machine_is_xxx(), CONFIG_XXX
> > > > and MACH_TYPE_XXX.
> > > > 
> > > > This patch fixes those mismatches and adds the devices back into
> > > > mach-types.
> > > > 
> > > > Cc: Nicolas Pitre <nico@fluxnic.net>
> > > > Cc: Lennert Buytenhek <kernel@wantstofly.org>
> > > > Cc: Russell King <linux@arm.linux.org.uk>
> > > > Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
> > > 
> > > Acked-by: Nicolas Pitre <nico@linaro.org>
> > > 
> > > Obviously, the change to mach-types should be done in the machine 
> > > registry database as well by RMK.
> > 
> > Which tree should this go through? Russell's or arm-soc?
> 
> The arm-soc tree is probably more appropriate.  Don't include the 
> mach-types changes though as it is preferable if they come through RMK's 
> database updates.

It's already gone through Russell's tree.

I realised that a mach-types patch couldn't go into arm-soc as that
doesn't have the removed machine entries, and the only other changes in
linux-next for the sheevaplug and ts209 files were from Russell's tree
anyway. And finally, I thought that Russel's mach-types generation
script would want to see the fixed files in his tree, otherwise it would
want to delete the machine entries.

-- 
Tixy
