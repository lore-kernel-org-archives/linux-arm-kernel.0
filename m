From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 10 Jan 2013 12:24:17 -0700
Subject: [PATCH 05/14] lib: Add I/O map cache implementation
In-Reply-To: <20130110190327.GA23110@avionic-0098.adnet.avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <20130109231758.GA27065@obsidianresearch.com>
 <20130110071937.GG15212@avionic-0098.adnet.avionic-design.de>
 <201301100917.19577.arnd@arndb.de>
 <20130110102544.GA5546@avionic-0098.adnet.avionic-design.de>
 <20130110182007.GA28004@obsidianresearch.com>
 <20130110185505.GA22944@avionic-0098.adnet.avionic-design.de>
 <20130110190327.GA23110@avionic-0098.adnet.avionic-design.de>
Message-ID: <20130110192417.GA18478@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 08:03:27PM +0100, Thierry Reding wrote:

> > > You'd piece a mapping together, each bus requires 16 64k mappings, a
> > > simple 2d array of busnr*16 of pointers would do the trick. A more
> > > clever solution would be to allocate contiguous virtual memory and
> > > split that up..
 
> > Oh, I see. I'm not very familiar with the internals of remapping, so
> > I'll need to do some more reading. Thanks for the hints.
> 
> I forgot to ask. What's the advantage of having a contiguous virtual
> memory area and splitting it up versus remapping each chunk separately?

Not alot, really, but it saves you from the pointer array and
associated overhead. IIRC it is fairly easy to do in the kernel.

Arnd's version is good too, but you would be restricted to aligned
powers of two for the bus number range in the DT, which is probably
not that big a deal either?

Jason
