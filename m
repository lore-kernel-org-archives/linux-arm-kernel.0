From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Wed, 7 Mar 2012 15:02:42 +0530
Subject: [PATCH 1/2] mach-ux500: cache operations are atomic on PL310
In-Reply-To: <20120117133428.GB11581@mudshark.cambridge.arm.com>
References: <1326346663-6112-1-git-send-email-srinidhi.kasagar@stericsson.com>
 <20120113181422.GB24373@mudshark.cambridge.arm.com>
 <20120116110528.GA24824@bnru02>
 <20120116145008.GH9068@mudshark.cambridge.arm.com>
 <20120117062224.GA26832@bnru02>
 <20120117103023.GB9230@mudshark.cambridge.arm.com>
 <20120117112741.GA14426@bnru02>
 <20120117133428.GB11581@mudshark.cambridge.arm.com>
Message-ID: <20120307093240.GA21265@bnru02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 14:34:28 +0100, Will Deacon wrote:
> On Tue, Jan 17, 2012 at 11:27:43AM +0000, Srinidhi KASAGAR wrote:
> > On Tue, Jan 17, 2012 at 11:30:23 +0100, Will Deacon wrote:
> > > On Tue, Jan 17, 2012 at 06:22:26AM +0000, Srinidhi KASAGAR wrote:
> > > > 
> > > > Yes, we boot with L2 enabled.
> > > 
> > > Interesting. I'm surprised you don't have problems with stale data on the
> > > D-side after the decompressor. Maybe you're lucky with the mappings being no
> > > write allocate.
> > 
> > Actually the pre bootloader makes sure that L2 is clean before relinquishing
> > the control to kernel decompressor.
> 
> I was thinking more of the decompressor populating the L2 and not flushing
> it.

Perhaps, we are lucky because we lock down l2 in bootloader?

srinidhi
