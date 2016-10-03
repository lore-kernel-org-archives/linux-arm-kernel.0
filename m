From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Mon, 3 Oct 2016 21:52:33 +0100
Subject: [PATCH] efi/arm: fix absolute relocation detection for older
 toolchains
In-Reply-To: <1475276515-21801-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1475276515-21801-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20161003205233.GO16071@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Sep, at 04:01:55PM, Ard Biesheuvel wrote:
> 
> This is a workaround for now. We can revisit this when a need arises to copy
> more kernel code into the stub, by which time we could put in a more elaborate
> fix, or decide to no longer care about 'older' versions of objcopy.
> 
> Since this fixes an ARM specific issue and only affects ARM specific Makefile
> variables, I am happy for this to go on top of the arm-soc patch that enables
> CONFIG_EFI for ARM's multi_v7_defconfig (queued for v4.9), given that we have
> no other changes queued in linux-efi that should conflict with this patch.
> 
> Matt, any concerns?

Not with the patch, but could we clarify the user-visible effects of
not applying it? Are the absolute relocations harmless, or will they
lead to crashes? 
