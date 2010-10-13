From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 13 Oct 2010 13:49:35 -0700
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <alpine.LFD.2.00.1010131638360.2764@xanadu.home>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<201010132145.30550.arnd@arndb.de>
	<1286999522.28336.15.camel@c-dwalke-linux.qualcomm.com>
	<201010132210.17061.arnd@arndb.de>
	<1287001466.28336.31.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1010131638360.2764@xanadu.home>
Message-ID: <1287002975.28336.44.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-10-13 at 16:44 -0400, Nicolas Pitre wrote:
> On Wed, 13 Oct 2010, Daniel Walker wrote:
> 
> > On Wed, 2010-10-13 at 22:10 +0200, Arnd Bergmann wrote:
> > > On Wednesday 13 October 2010 21:52:02 Daniel Walker wrote:
> > > > > Seriously, I don't think you need it, but if you really do, we can probably
> > > > > find a way to work around this by changing the base hvc driver.
> > > > 
> > > > I think we would have to add something that allows different major/minor
> > > > numbers, because something that includes the name "Hypervisor" shouldn't
> > > > be used for something general.. /dev/hvcX is also registered for "IBM
> > > > iSeries/pSeries virtual console" (according to www.lanana.org) which is
> > > > confusing ..
> > > 
> > > That only means we need to update the lanana entry now that the hvc driver
> > > is used on nine different platforms (not including yours) instead of ust
> > > pSeries. Feel free to come up with a backronym for HVC if you're
> > > uncomfortable with the old "hypervisor console" name.
> > 
> > If you read back in this thread you'll see how there was a discussion
> > already on how you shouldn't re-use major/minor numbers for other
> > purposes .. It looks like "hvc" was essentially overridden , which now
> > seems like a no-no given that discussion.. This appears to be a
> > sensitive topic.
> 
> And I violently disagree with this interpretation.
> 
> The tty layer was probably the first subsystem to have been implemented 
> in Linux.  There are a big deal of legacy with its device naming.  When 
> adding new subsystems we don't need to perpetuate this. Maybe that made 
> sense 20 years ago, but let's leave ttyS0 alone and use good sense for 
> new stuff.

Your still confusing me here Nico .. It seems like your suggesting
adding new overrides is not OK , yet your also saying it is ok ?

Are you saying overrides are OK for anything other than ttyS ?

Daniel


-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
