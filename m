From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 17 Aug 2016 13:17:51 +0200
Subject: [PATCH v2] kvm: arm: Enforce some NS-SVC initialisation
In-Reply-To: <6d030bee2db08c2fe1b7569e692e8f66800b1e4c.1471369569.git.robin.murphy@arm.com>
References: <5322cdb9cb397741d15b60c6693ad39dbf74b6d5.1469101945.git.robin.murphy@arm.com>
 <6d030bee2db08c2fe1b7569e692e8f66800b1e4c.1471369569.git.robin.murphy@arm.com>
Message-ID: <20160817111751.GG8808@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Aug 16, 2016 at 06:49:18PM +0100, Robin Murphy wrote:
> Since the non-secure copies of banked registers lack architecturally
> defined reset values, there is no actual guarantee when entering in Hyp
> from secure-only firmware that the Non-Secure PL1 state will look the
> way that kernel entry (in particular the decompressor stub) expects.
> So far, we've been getting away with it thanks to implementation details
> of ARMv7 cores and/or bootloader behaviour, but for the sake of forwards
> compatibility let's try to ensure that we have a minimally sane state
> before dropping down into it.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Can we have your acked-by on this patch to merge it via the KVM tree or
do you prefer merging this one directly yourself?

Thanks,
-Christoffer
