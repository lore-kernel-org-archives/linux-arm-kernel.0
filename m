From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 17 Jul 2015 11:28:23 +0200
Subject: [PATCH v4 0/2] arm/arm64: KVM: Optimize arm64 fp/simd, saves
 30-50% on exits
In-Reply-To: <1437082178-11039-1-git-send-email-m.smarduch@samsung.com>
References: <1437082178-11039-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <20150717092823.GG14024@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 02:29:36PM -0700, Mario Smarduch wrote:
> Currently we save/restore fp/simd on each exit. The first patch optimizes arm64
> save/restore, we only do so on Guest access. hackbench and several lmbench
> tests show anywhere from 30% to 50% of exits don't context switch the vfp/simd
> registers.
> 
> For second patch 32-bit handler is updated to keep exit handling consistent
> with 64-bit code.
> 

For the series:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
