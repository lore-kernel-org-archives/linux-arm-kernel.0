From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2011 21:34:50 +0000
Subject: arm and patch phys offset
In-Reply-To: <201112122212.35506.michael@walle.cc>
References: <201112112255.32534.michael@walle.cc>
 <alpine.LFD.2.02.1112111935590.2907@xanadu.home>
 <201112122212.35506.michael@walle.cc>
Message-ID: <20111212213450.GD20178@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 10:12:35PM +0100, Michael Walle wrote:
> Am Montag 12 Dezember 2011, 01:53:42 schrieb Nicolas Pitre:
> > On Sun, 11 Dec 2011, Michael Walle wrote:
> > > I have a marvell kirkwood based LS-CHLv2 board and running the latest
> > > HEAD of linus tree (with my dts patched for the kirkwood port, but
> > > hopefully this should be unrelated to this problem).
> > 
> > Did you try without those patches to be sure?
> clean linux tree with old fashioned setup code now (the one i sent long time 
> ago to this mailinglist ;).
> 
> > > The weird thing is that this output changes if i insert or move some
> > > debug prints. I even accomplished to make the board boot completely
> > > sometimes.
> > 
> > You must have some memory corrupting bug somewhere.  Please try calling
> > this code first thing in start_kernel() for comparison.
> 
> calling the dump function right at the beginning of start_kernel() won't 
> change anything, expect the addresses.

Why do you say that, and what you do mean by "expect the addresses" ?
Presumably you're saying the addresses will be different.  Why do you
think that?

Are you saying that you find that the address of these 'unconverted'
instructions change each time you run your debug function?

> If it would be some memory corruption, shouldn't the table or the p2v/v2p 
> stubs be corrupt? But the non-patched entries always points to correct v2p/p2v 
> calls and in every case there is the unpatched add/sub instruction. 

Have you tried dumping out the entire instruction as well as the
address of the unconverted instruction?

Are you running a Thumb-2 kernel?  Which kernel are you running?
