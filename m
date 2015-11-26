From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 26 Nov 2015 10:33:49 +0000
Subject: [PATCH 2/2] arm64: efi: fix initcall return values
In-Reply-To: <1448264604-19411-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1448264604-19411-1-git-send-email-ard.biesheuvel@linaro.org>
 <1448264604-19411-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151126103349.GG2765@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Nov, at 08:43:24AM, Ard Biesheuvel wrote:
> Even though initcall return values are typically ignored, the
> prototype is to return 0 on success or a negative errno value on
> error. So fix the arm_enable_runtime_services() implementation to
> return 0 on conditions that are not in fact errors, and return a
> meaningful error code otherwise.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/efi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

FWIW, 

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
