From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 15 Jul 2016 16:05:53 +0100
Subject: [PATCH v2 1/2] efi: esrt: use memremap not ioremap to access
 ESRT table in memory
In-Reply-To: <1468263646-28184-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1468263646-28184-1-git-send-email-ard.biesheuvel@linaro.org>
 <1468263646-28184-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160715150553.GD2406@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jul, at 09:00:45PM, Ard Biesheuvel wrote:
> On ARM and arm64, ioremap() and memremap() are not interchangeable like
> on x86, and the use of ioremap() on ordinary RAM is typically flagged
> as an error if the memory region being mapped is also covered by the
> linear mapping, since that would lead to aliases with conflicting
> cacheability attributes.
> 
> Since what we are dealing with is not an I/O region with side effects,
> using ioremap() here is arguably incorrect anyway, so let's replace
> it with memremap() instead.
> 
> Acked-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/esrt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Looks sensible, thanks Ard, applied.
