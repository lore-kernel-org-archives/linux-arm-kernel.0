From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 16 Jan 2013 12:52:25 +0100
Subject: [PATCH 05/14] lib: Add I/O map cache implementation
In-Reply-To: <20130116112556.GR23505@n2100.arm.linux.org.uk>
References: <20130109231758.GA27065@obsidianresearch.com>
 <20130110071937.GG15212@avionic-0098.adnet.avionic-design.de>
 <201301100917.19577.arnd@arndb.de>
 <20130110102544.GA5546@avionic-0098.adnet.avionic-design.de>
 <20130110182007.GA28004@obsidianresearch.com>
 <20130110185505.GA22944@avionic-0098.adnet.avionic-design.de>
 <20130110190327.GA23110@avionic-0098.adnet.avionic-design.de>
 <20130110192417.GA18478@obsidianresearch.com>
 <20130116101822.GA17706@avionic-0098.adnet.avionic-design.de>
 <20130116112556.GR23505@n2100.arm.linux.org.uk>
Message-ID: <20130116115225.GA15873@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 11:25:56AM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 16, 2013 at 11:18:22AM +0100, Thierry Reding wrote:
> > 		err = ioremap_page_range(virt, virt + SZ_64K - 1, phys,
> 
> Why -1 here?

Right, I forgot that end in these functions always means one byte after
the end. Removing the -1 seems to get past the remapping at least.
Reading the configuration space through the mapping doesn't though. I'll
investigate some more.

Thanks for pointing this out Russell.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130116/c42c59ae/attachment.sig>
