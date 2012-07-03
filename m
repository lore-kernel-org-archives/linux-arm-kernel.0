From: kim.phillips@freescale.com (Kim Phillips)
Date: Tue, 3 Jul 2012 15:29:46 -0500
Subject: [PATCH] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <20120703150406.GH22705@S2101-09.ap.freescale.net>
References: <1341245355-21397-1-git-send-email-shawn.guo@linaro.org>
 <20120702183736.e8e4136d4bf206b55c8653a5@freescale.com>
 <20120703150406.GH22705@S2101-09.ap.freescale.net>
Message-ID: <20120703152946.c2684e9da3256fedd559f039@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Jul 2012 23:04:08 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> On Mon, Jul 02, 2012 at 06:37:36PM -0500, Kim Phillips wrote:
> > Instead of duplicating the binding documentation entry, can this be
> > merged in with crypto/fsl-sec4.txt?
> 
> Yes. We can do that.  But I would still keep a plain
> Documentation/devicetree/bindings/rtc/snvs-rtc.txt there with only
> a pointer to Documentation/devicetree/bindings/crypto/fsl-sec4.txt.
> Otherwise, I'm afraid that people will hardly know the bindings of
> snvs-rtc is documented in fsl-sec4.txt.

that's understandable.

> > Also, don't we need the rtc to
> > be a 'sub-device' of "fsl,sec-vX.Y-mon", and to have its own
> > compatible, e.g., "fsl,sec-v4.0-mon-rtc-lp"?
> > 
> Sounds sensible.  But how will reg and interrupts properties be
> documented?  The registers for lp-rtc is not so consecutive and

LP registers go from 0x34 (LPLR) to 0x8b (LPZMKR7), consecutively.
HP registers technically would have a split range, but this patch
doesn't address the HP part.

> interrupts are shared by hp and lp.

that's why we return IRQ_NONE, so we can request_irq IRQF_SHARED.

> > > +config RTC_DRV_SNVS
> > > +	tristate "Freescale SNVS RTC support"
> > > +	depends on ARCH_MXC
> > 
> > should also depend on || FSL_SOC - it was mentioned in the
> > review of the last version of this patch that this h/w exists on
> > other, non-ARM based, SoCs.
> > 
> I would not do that until the driver is tested on FSL_SOC.

I can test it.

> Also I'm
> considering to take Stephen's suggestion to drop even ARCH_MXC.

fine with me.

Kim
