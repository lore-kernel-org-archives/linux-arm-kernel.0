From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Jun 2012 23:55:20 +0100
Subject: [PATCH 15/16] ARM: fiq: save FIQ_START by passing absolute fiq
 number
In-Reply-To: <20120619052654.GC21951@S2101-09.ap.freescale.net>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-16-git-send-email-shawn.guo@linaro.org>
 <20120618143128.GF19249@S2101-09.ap.freescale.net>
 <20120618164402.GA18630@n2100.arm.linux.org.uk>
 <20120619052654.GC21951@S2101-09.ap.freescale.net>
Message-ID: <20120620225520.GA30087@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 01:26:56PM +0800, Shawn Guo wrote:
> On Mon, Jun 18, 2012 at 05:44:02PM +0100, Russell King - ARM Linux wrote:
> > FIQs should be an entirely separate number space from IRQs, as we
> > may want to totally decouple them from the IRQ stuff (we probably
> > should have already done this when genirq came along.)
> > 
> > About the only stuff FIQs use is the enable/disable_irq as a short
> > cut to dealing with the mask registers.
> 
> I do not quite understand what you are asking for, but I'm guessing it
> with the patch below.  Please elaborate it a little bit more if that's
> not what you are asking for.

I was thinking about moving entirely away from any bits of genirq for
this.  We shouldn't really be mixing these two things together by
nabbing some of the IRQ numberspace for this.

Looking at this code, I'm thinking about taking this further, and
santising the whole thing... though that's not going to be a quick
change.
