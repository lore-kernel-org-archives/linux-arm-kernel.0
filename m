From: js@sig21.net (Johannes Stezenbach)
Date: Mon, 8 Dec 2014 17:50:16 +0100
Subject: using DMA-API on ARM
In-Reply-To: <20141208155556.GL16185@e104818-lin.cambridge.arm.com>
References: <5481794E.4050406@broadcom.com>
 <20141205183945.GE31222@e104818-lin.cambridge.arm.com>
 <20141205185303.GG31222@e104818-lin.cambridge.arm.com>
 <20141208125538.GA26983@sig21.net>
 <20141208155556.GL16185@e104818-lin.cambridge.arm.com>
Message-ID: <20141208165016.GA28471@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 03:55:57PM +0000, Catalin Marinas wrote:
> On Mon, Dec 08, 2014 at 12:55:38PM +0000, Johannes Stezenbach wrote:
> > On Fri, Dec 05, 2014 at 06:53:03PM +0000, Catalin Marinas wrote:
> > > 
> > > BTW, if you really have a PL310-like L2 cache, have a look at some
> > > patches (I've seen similar symptoms) and make sure your configuration is
> > > correct:
> > > 
> > > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6395/1
> > > 
> > > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6529/1
> > > 
> > > The first one is vexpress specific. The second one was eventually
> > > discarded by Russell (I don't remember the reason, I guess it's because
> > > SoC code is supposed to set the right bits in there anyway). In your
> > > case, such bits may be set up by firmware, so Linux cannot fix anything
> > > up.
> > 
> > How do you avoid the unpredictable behavior mentioned in the
> > PL310 TRM when the Shared Attribute Invalidate Enable bit is set?
> > http://infocenter.arm.com/help/topic/com.arm.doc.ddi0246h/Ceggcfcj.html
> 
> So you talk about "Shared Attribute _Invalidate_ Enable" (bit 13) while
> I talk about "Shared Attribute _Override_ Enable" (bit 22).
> 
> In addition, Shared _Invalidate_ behaviour can only be enabled if Shared
> Attribute _Override_ Enable bit is not set.

Yeah, I got confused, sorry for the noise.

Thanks,
Johannes
