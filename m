From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 26 Nov 2015 10:29:54 +0000
Subject: [PATCH 1/2] arm64/efi: deal with NULL return value of
 early_memremap()
In-Reply-To: <1448264604-19411-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1448264604-19411-1-git-send-email-ard.biesheuvel@linaro.org>
 <1448264604-19411-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151126102954.GF2765@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Nov, at 08:43:23AM, Ard Biesheuvel wrote:
> Add NULL return value checks to two invocations of early_memremap()
> in the UEFI init code. For the UEFI configuration tables, we just
> warn since we have a better chance of being able to report the issue
> in a way that can actually be noticed by a human operator if we don't
> abort right away. For the UEFI memory map, however, all we can do is
> panic() since we cannot proceed without a description of memory.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/efi.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
