From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 5 Jun 2012 16:29:10 -0700
Subject: [PATCH 0/8] Rework KERN_<LEVEL>
In-Reply-To: <1338936572.5780.29.camel@joe2Laptop>
References: <cover.1338889066.git.joe@perches.com>
 <20120605142826.d92316a0.akpm@linux-foundation.org>
 <1338934303.5780.8.camel@joe2Laptop>
 <20120605151754.a794ac7c.akpm@linux-foundation.org>
 <1338936572.5780.29.camel@joe2Laptop>
Message-ID: <20120605162910.caccb0d4.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 05 Jun 2012 15:49:32 -0700
Joe Perches <joe@perches.com> wrote:

> On Tue, 2012-06-05 at 15:17 -0700, Andrew Morton wrote:
> > On Tue, 05 Jun 2012 15:11:43 -0700
> > Joe Perches <joe@perches.com> wrote:
> > 
> > > On Tue, 2012-06-05 at 14:28 -0700, Andrew Morton wrote:
> > > > Unfortunately the <n> thing is part of the kernel ABI:
> > > > 
> > > > 	echo "<4>foo" > /dev/kmsg
> > > 
> > > Which works the same way it did before.
> > 
> > I didn't say it didn't.
> > 
> > What I did say is that echo "\0014">/dev/kmsg will subvert the intent
> > of the new logging code.  Or might.  But you just ignored all that,
> > forcing me to repeat myself, irritatedly.
> 
> It works the same way before and after the patch.
> 
> Any write to /dev/kmsg without a KERN_<LEVEL>
> emits at (1 << 3) + KERN_DEFAULT.
> 
> Writes with <n> values >= 8 are emitted at
> that level.

What about writes starting with \001n?  AFACIT, that will be stripped
away and the printk level will be altered.  This is new behavior.
