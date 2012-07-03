From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Jul 2012 23:04:08 +0800
Subject: [PATCH] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <20120702183736.e8e4136d4bf206b55c8653a5@freescale.com>
References: <1341245355-21397-1-git-send-email-shawn.guo@linaro.org>
 <20120702183736.e8e4136d4bf206b55c8653a5@freescale.com>
Message-ID: <20120703150406.GH22705@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 06:37:36PM -0500, Kim Phillips wrote:
> Instead of duplicating the binding documentation entry, can this be
> merged in with crypto/fsl-sec4.txt?

Yes. We can do that.  But I would still keep a plain
Documentation/devicetree/bindings/rtc/snvs-rtc.txt there with only
a pointer to Documentation/devicetree/bindings/crypto/fsl-sec4.txt.
Otherwise, I'm afraid that people will hardly know the bindings of
snvs-rtc is documented in fsl-sec4.txt.

> Also, don't we need the rtc to
> be a 'sub-device' of "fsl,sec-vX.Y-mon", and to have its own
> compatible, e.g., "fsl,sec-v4.0-mon-rtc-lp"?
> 
Sounds sensible.  But how will reg and interrupts properties be
documented?  The registers for lp-rtc is not so consecutive and
interrupts are shared by hp and lp.

> > +config RTC_DRV_SNVS
> > +	tristate "Freescale SNVS RTC support"
> > +	depends on ARCH_MXC
> 
> should also depend on || FSL_SOC - it was mentioned in the
> review of the last version of this patch that this h/w exists on
> other, non-ARM based, SoCs.
> 
I would not do that until the driver is tested on FSL_SOC.  Also I'm
considering to take Stephen's suggestion to drop even ARCH_MXC.

-- 
Regards,
Shawn
