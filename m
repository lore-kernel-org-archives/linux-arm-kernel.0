From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Jan 2015 11:27:37 +0000
Subject: [PATCH 3/7] arm64: remove ESR_EL1_* macros
In-Reply-To: <20150111180805.GJ21444@cbox>
References: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
 <1420632260-8798-4-git-send-email-mark.rutland@arm.com>
 <20150111180805.GJ21444@cbox>
Message-ID: <20150112112737.GC16706@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 11, 2015 at 06:08:05PM +0000, Christoffer Dall wrote:
> On Wed, Jan 07, 2015 at 12:04:16PM +0000, Mark Rutland wrote:
> > Now that all users have been moved over to the common ESR_ELx_* macros,
> > remove the redundant ESR_EL1 macros.
> > 
> > There should be no functional change as a result of this patch.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Christoffer Dall <christoffer.dall@linaro.org>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> 
> FYI: This breaks bisectability with KVM, so we should probably move the
> existing KVM references to the common definitions as part of this patch?

Sorry about that, evidently I forgot the KVM code referred to some
ESR_EL1_* definitions when I reorganised the series.

Are you happy if I just move this patch after the KVM changes? That
should keep everything bisectable and leaves the KVM changes confined to
a single patch.

Thanks,
Mark.
