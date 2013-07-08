From: hpa@linux.intel.com (H. Peter Anvin)
Date: Mon, 08 Jul 2013 15:16:14 -0700
Subject: [PATCH v3 5/5] lib/raid6: add ARM-NEON accelerated syndrome
 calculation
In-Reply-To: <1373321521-15485-6-git-send-email-ard.biesheuvel@linaro.org>
References: <1373321521-15485-1-git-send-email-ard.biesheuvel@linaro.org>
 <1373321521-15485-6-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <51DB3A2E.9070409@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2013 03:12 PM, Ard Biesheuvel wrote:
> Rebased/reworked a patch contributed by Rob Herring that uses
> NEON intrinsics to perform the RAID-6 syndrome calculations.
> It uses the existing unroll.awk code to generate several
> unrolled versions of which the best performing one is selected
> at boot time.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Cc: hpa at linux.intel.com

I can't comment on the correctness of the code since I'm not familiar
with the Neon instruction set, but I don't see anything inherently
problematic with the patchset either.

	-hpa
