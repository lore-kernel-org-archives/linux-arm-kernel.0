From: Trond.Myklebust@netapp.com (Trond Myklebust)
Date: Thu, 30 Dec 2010 12:59:52 -0500
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <20101230171453.GA5787@pengutronix.de>
References: <20101230171453.GA5787@pengutronix.de>
Message-ID: <1293731992.4919.5.camel@heimdal.trondhjem.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-12-30 at 18:14 +0100, Uwe Kleine-K?nig wrote: 
> Hello,
> 
> I wonder if the nfs-stuff is considered to be solved, because I still
> see strange things.
> 
> During boot my machine sometimes (approx one out of two times) hangs with
> the output pasted below on Sysctl-l.  The irq 
> 
> I'm not 100% sure it's related, but at least it seems to hang in
> nfs_readdir.  (When the serial irq happend that triggered the sysrq the
> program counter was at 0xc014601c, which is fs/nfs/dir.c:647 for me.)
> 
> This is on 2.6.37-rc8 plus some patches for machine support on an ARM
> machine.

Ccing linux-nfs at vger.kernel.org

What filesystem are you exporting on the server? What is the NFS
version? Is this nfsroot, autofs or an ordinary nfs mount?

In short, how can we reproduce this?

Trond
-- 
Trond Myklebust
Linux NFS client maintainer

NetApp
Trond.Myklebust at netapp.com
www.netapp.com
