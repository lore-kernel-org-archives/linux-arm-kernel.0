From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Aug 2016 15:48:03 +0100
Subject: [PATCH v2 0/9] arm64: clean up early boot function calls
In-Reply-To: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1472049366-10922-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160830144803.GM1223@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 24, 2016 at 04:35:57PM +0200, Ard Biesheuvel wrote:
> This v2 series is a followup to the single patch #1, whose v1 I sent out
> about a week ago.
> 
> In a couple of places, the early boot code uses non-standard argument,
> return value or return address registers when calling functions. This makes
> the code more complicated than it needs to be, which was not a problem in the
> early days, but with all the recent changes for KASLR, hibernate etc, it
> makes sense to clean this up once and for all. This code removes all uses of
> callee saved registers on the secondary boot and resume paths, and on th
> primary boot path, it only leaves the necessary ones, and documents them
> explicitly in patch #9.
> 
> I will leave it to the honourable arm64 maintainers to decide if any of
> these improvements weigh up against the churn, given that this code has
> already been updated numerous times over the past couple of kernel versions.

Which ones are honourable? ;)

FWIW, I think that overall this is a nice improvement in legibility for
the boot code.

> Adding James to cc since patch #6 may conflict with this hibernate/
> debug-pagealloc series [0], to which I replied that merging .idmap.text
> with .mmuoff.text would be a worthwhile simplification. 

I'll leave it to you, James, and the honourable maintainers to figure
out the details on that front.

I've given this a spin on Juno (R1) with KASAN and CONFIG_RANDOMIZE_BASE
selected (though I have no entropy source, so I'm bailing out early).
That all works, so for the series:

Tested-by: Mark Rutland <mark.rutland@arm.com>

For patch 1, feel free to upgrade the Acked-by to a Reviewed-by to match
the rest of the series.

Thanks,
Mark.
