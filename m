From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Oct 2012 08:11:42 +0000
Subject: alignment faults in 3.6
In-Reply-To: <yw1xtxu1nfsn.fsf@unicorn.mansr.com>
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <AE90C24D6B3A694183C094C60CF0A2F6026B703E@saturn3.aculab.com>
 <yw1xtxu1nfsn.fsf@unicorn.mansr.com>
Message-ID: <201210120811.43290.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 October 2012, M?ns Rullg?rd wrote:
> > But, the IP header is expected to be aligned.
> 
> Everything tells the compiler the struct is perfectly aligned.  When the
> buggy driver passes a misaligned pointer, bad things happen.

Would it be appropriate to add a WARN_ON_ONCE() in the alignment fault path
then? If all alignment faults in the kernel are caused by broken drivers,
that would at least give us some hope of finding those drivers while at the
same time not causing much overhead in the case where we need to do the
fixup in the meantime.

	Arnd
