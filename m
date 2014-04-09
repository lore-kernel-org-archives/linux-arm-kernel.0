From: w@1wt.eu (Willy Tarreau)
Date: Wed, 9 Apr 2014 09:47:52 +0200
Subject: [PATCH v2] bus: mvebu-mbus: Avoid setting an undefined window size
In-Reply-To: <20140409091234.20f2e547@skate>
References: <1397000654-10849-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20140409061128.GC16465@1wt.eu> <20140409091234.20f2e547@skate>
Message-ID: <20140409074752.GF16465@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 09:12:34AM +0200, Thomas Petazzoni wrote:
> Dear Willy Tarreau,
> 
> On Wed, 9 Apr 2014 08:11:29 +0200, Willy Tarreau wrote:
> 
> > The WARN is correctly emitted for both igb ports here, but unfortunately
> > despite EINVAL, I still get the panic. Also I find it surprizing that it
> > reports sizes ending in ffff. I read the patch and it looks correct, so
> > we possibly have something else wrong here.
> 
> Yes, the panic is expected: Jason's patch is not *fixing* anything,
> it's just telling you *why* it's going to panic.

I just thought that the EINVAL would prevent one from registering
the device, which would be more useful (if at all possible).

Willy
