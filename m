From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 13 Apr 2011 11:44:09 -0400 (EDT)
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <201104130851.17676.pwaechtler@mac.com>
References: <201104122052.17453.pwaechtler@mac.com>
	<BANLkTin0NMo7ZDrnTmBghYeRC9wxJu7zrw@mail.gmail.com>
	<201104130851.17676.pwaechtler@mac.com>
Message-ID: <alpine.LFD.2.00.1104131128070.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Apr 2011, Peter W?chtler wrote:

> Am Dienstag, 12. April 2011, 21:20:14 schrieb Andrei Warkentin:
> > How are you mounting your rootfs and what file system are you using?
> > What sort of corruptions to the super block are you seeing?
> > 
> 
> It's using ext4 with metadata journalling in ordered mode.
> I had to check "if it's the FS" - the test programs create lots of directories 
> and files while a timer is armed to issue a soft reset.
> The partitions where the "stress tests" run on - survive it happily - just the 
> rootfs where almost nothing gets written is severly damaged so that fsck.ext4 
> will not repair it automatically.

SD cards are doing their own wear leveling internally and you have no 
control over it.  Some blocks of data may be moved around, affecting a 
separate logical partition, even if you are not actively writing to that 
partition.  Now if you cut power or reset the card while this is 
happening you'll certainly end up with data loss.  Those SD cards are 
made to be both cheap and fast, meaning they're certainly not reliable 
with regards to unexpected interruptions.

Furthermore, you should have a look at this article and referenced 
material: http://lwn.net/Articles/428584/.


Nicolas
