From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Mar 2018 17:40:58 +0000
Subject: [RFC PATCH v3 0/3] arm64/kernel: get rid of GCC large model code
In-Reply-To: <20180214113645.16793-1-ard.biesheuvel@linaro.org>
References: <20180214113645.16793-1-ard.biesheuvel@linaro.org>
Message-ID: <20180305174057.GC13385@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 11:36:42AM +0000, Ard Biesheuvel wrote:
> I am resending this as an RFC, because I'd like to understand whether
> anyone else shares my concern, or whether I am being overly paranoid.
> 
> v2 blurb:
> 
> GCC's large model uses literal pools to emit cross object symbol
> references rather than movz/movk sequences, resulting in data items
> mixed in the with executable code in modules' .text segments, reducing
> cache utilization, but also potentially resulting in the creation of
> code gadgets that are exploitable under speculative execution.
> 
> We are using GCC's large model for two separate reasons, both of which can
> be worked around rather easily:
> - KASLR uses it to move modules and the kernel very far apart, which is
>   not really needed,
> - the Cortex-A53 erratum code uses it to avoid ADRP instruction altogether,
>   which can be replaced by selective patching of only the ADRP instructions
>   that are affected by the erratum

I think this is a sensible thing to do, cheers.

Will
