From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 08 Mar 2013 19:57:09 +0100
Subject: s3c24xx pinctrl help
In-Reply-To: <201303081538.04877.heiko@sntech.de>
References: <201303081538.04877.heiko@sntech.de>
Message-ID: <2034100.l6yoVjE7uo@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Friday 08 of March 2013 15:38:04 Heiko St?bner wrote:
> Hi Thomas,
> 
> taking you up on your offer of helping, I would be cool if you could
> simply give me a push in the right direction :-) .
> 
> 
> From what I've seen so far, the bank handling itself is very similar
> between exynos and s3c24xx as the underlying structures already handle
> multiple widths of the register contents. More interesting is the eint
> handling around which I couldn't wrap my head yet.
> 
> The basic structure is again similar with special eint registers, but
> adds some quirks. EINT banks are gpf (8 eints) and gpg (8 or 16 eints
> depending on the SoC).
> 
> The current way on Exynos seems to be to mark the offset in the eint
> register and attach an irq_domain to the bank, which gets mapped to the
> eints starting at the offset. The eints seem to have a parent interrupt
> that is provided via the dt.
> 
> On the S3C24xx the gpg bank is doing this similar but gpf is very
> strange.
> 
> The first half of the bank (gpf0 to gpf3) is not handled in eintpend
> registers but in the main interrupt controller (bits 0 to 3), while the
> second half of gpf is handled in eintpend. The new interrupt
> declaration might show this better, which can be found at [0].
> 
> An exception is the s3c2412 which adds still another quirk where each
> interrupt of gpf0 to gpf3 is represented in both the normal intc and
> eint registers, again for reference probably easier to see in [1].
> 
> 
> So I'm still quite stumped on how this could fit into the current
> framework and would be really glad for some small pointers :-)

I wonder if some of my patches for pinctrl on S3C64xx might be helpful:

https://github.com/tom3q/linux/commits/v3.8-s3c64xx-dt-pinctrl

Best regards,
Tomasz
