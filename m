From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Oct 2013 16:52:30 +0100
Subject: [PATCH v2] ARM: tlb: ASID macro should give 32bit result for
 BE correct operation
In-Reply-To: <1381160903-1248-2-git-send-email-victor.kamensky@linaro.org>
References: <1381160903-1248-1-git-send-email-victor.kamensky@linaro.org>
 <1381160903-1248-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20131007155230.GQ12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 08:48:23AM -0700, Victor Kamensky wrote:
> -#define ASID(mm)	((mm)->context.id.counter & ~ASID_MASK)
> +#define ASID(mm)	((unsigned int)((mm)->context.id.counter & ~ASID_MASK))

Not a big problem, but "unsigned" is sufficient as per my suggestion.
See:

	http://en.wikipedia.org/wiki/C_data_types

or look it up in the C standards. :)  I'll take it either way.
