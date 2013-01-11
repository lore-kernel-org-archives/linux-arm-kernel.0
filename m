From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Jan 2013 14:07:58 +0000
Subject: [PATCHv2 02/11] arm: arch_timer: remove redundant available check
In-Reply-To: <50F00F8D.3050904@ti.com>
References: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
 <1357747640-18594-3-git-send-email-mark.rutland@arm.com>
 <50F00F8D.3050904@ti.com>
Message-ID: <20130111140748.GA19765@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 01:11:41PM +0000, Santosh Shilimkar wrote:
> On Wednesday 09 January 2013 09:37 PM, Mark Rutland wrote:
> > This check is a holdover from the pre-devicetree days. As the timer
> > is not probed except by platforms which register it via devicetree,
> > it's not strictly necessary.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> Multi-platform build without DT could still benefit from the
> check but I guess the most of the A15 based platform are DT
> only, so its should be good to get rid of the check.

Indeed. I'm under the impression that all platforms which might have an
architected timer are devicetree only.

> 
> Regards,
> Santosh
> 

Thanks,
Mark.
