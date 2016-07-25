From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 25 Jul 2016 15:22:42 +0100
Subject: [PATCH 1/2] arm64: mm: make create_mapping_late() non-allocating
In-Reply-To: <3728BEC2-B1C8-40A5-9E0C-E27D56149BD4@linaro.org>
References: <1469208745-6693-1-git-send-email-ard.biesheuvel@linaro.org>
 <1469208745-6693-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160725134550.GA14465@leverpostej>
 <3728BEC2-B1C8-40A5-9E0C-E27D56149BD4@linaro.org>
Message-ID: <20160725142241.GC14465@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2016 at 04:10:50PM +0200, Ard Biesheuvel wrote:
> > On 25 jul. 2016, at 15:46, Mark Rutland <mark.rutland@arm.com> wrote:
> > How about we drop the __init marker from create_mapping_noalloc(), and
> > update the callers in mark_rodata_ro() to use that, so that we can drop
> > create_mapping_late() entirely.
> > 
> > Other than the __init marker and name, create_mapping_late() and
> > create_mapping_noalloc() would be identical after this change, and the
> > naming of create_mapping_noalloc() does better describe what we're
> > trying to achieve in mark_rodata_ro().
> 
> Not entirely. The _late() variant should map down to pages if the
> first mapping was mapped down to pages as well. The _noalloc() variant
> may end attempting to merge regions

Ah, I was comparing against mainline rather than the arm64 for-next/core
branch with the recent rework. Sorry for the noise.

Given that, FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
