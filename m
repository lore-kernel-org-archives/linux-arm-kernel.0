From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Wed, 26 Aug 2015 18:24:55 +0100
Subject: [PATCH 2/3] arm64: use core efi=debug instead of uefi_debug
 command line parameter
In-Reply-To: <1440595498-30630-3-git-send-email-leif.lindholm@linaro.org>
References: <1440595498-30630-1-git-send-email-leif.lindholm@linaro.org>
 <1440595498-30630-3-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20150826172455.GB2837@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Aug, at 02:24:57PM, Leif Lindholm wrote:
> Now that we have an efi=debug command line option in the core code, use
> this instead of the arm64-specific uefi_debug option.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  Documentation/arm/uefi.txt |  2 --
>  arch/arm64/kernel/efi.c    | 19 +++++--------------
>  2 files changed, 5 insertions(+), 16 deletions(-)

Are there no concerns with backwards-compatibility here? I expected
this patch to internally convert uefi_debug to efi=debug if old boot
loaders, kernel config, etc specify it.

Is that something that can be safely ignored?

-- 
Matt Fleming, Intel Open Source Technology Center
