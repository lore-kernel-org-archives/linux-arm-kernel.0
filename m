From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Jul 2014 17:47:11 +0100
Subject: [PATCH] arm64/crypto: fix makefile rule for aes-glue-%.o
In-Reply-To: <1406217806-15538-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1406217806-15538-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140724164711.GM13371@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 05:03:26PM +0100, Ard Biesheuvel wrote:
> From: Andreas Schwab <schwab@suse.de>
> 
> This fixes the following build failure when building with CONFIG_MODVERSIONS
> enabled:
> 
>   CC [M]  arch/arm64/crypto/aes-glue-ce.o
> ld: cannot find arch/arm64/crypto/aes-glue-ce.o: No such file or directory
> make[1]: *** [arch/arm64/crypto/aes-ce-blk.o] Error 1
> make: *** [arch/arm64/crypto] Error 2
> 
> The $(obj)/aes-glue-%.o rule only creates $(obj)/.tmp_aes-glue-ce.o, it
> should use if_changed_rule instead of if_changed_dep.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> [ardb: mention CONFIG_MODVERSIONS in commit log]
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> Catalin,
> 
> Could you take this for 3.17 please? It fixes a build error when building
> aes-ce-blk and/or aes-neon-blk as modules with CONFIG_MODVERSIONS enabled.

Queued for 3.17. Thanks.

-- 
Catalin
