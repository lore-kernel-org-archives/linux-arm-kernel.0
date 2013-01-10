From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 10 Jan 2013 14:06:14 -0700
Subject: [PATCH 05/14] lib: Add I/O map cache implementation
In-Reply-To: <20130110202007.GA26139@avionic-0098.adnet.avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <20130109231758.GA27065@obsidianresearch.com>
 <20130110071937.GG15212@avionic-0098.adnet.avionic-design.de>
 <201301100917.19577.arnd@arndb.de>
 <20130110102544.GA5546@avionic-0098.adnet.avionic-design.de>
 <20130110182007.GA28004@obsidianresearch.com>
 <20130110185505.GA22944@avionic-0098.adnet.avionic-design.de>
 <20130110190327.GA23110@avionic-0098.adnet.avionic-design.de>
 <20130110192417.GA18478@obsidianresearch.com>
 <20130110202007.GA26139@avionic-0098.adnet.avionic-design.de>
Message-ID: <20130110210614.GA21836@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 09:20:07PM +0100, Thierry Reding wrote:

> > Arnd's version is good too, but you would be restricted to aligned
> > powers of two for the bus number range in the DT, which is probably
> > not that big a deal either?
> 
> Stephen suggested on IRC that we could try to keep a bit of dynamicity
> in the allocation scheme if we create the bus mapping when the first
> device on the bus is probed and discard the mapping if no devices are
> found.

You probably don't need to mess around with 'discard on empty' the
kernel should only access bus numbers that are in the range of the
subordinate busses of the bridges. So if you establish a mapping on a
bus-by-bus basis at first access, it should be fine and very close to
minimal..

Jason
