From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 6 Jan 2015 09:13:22 +0000
Subject: [PATCH 2/8] arm64/efi: register UEFI reserved regions as iomem
 resources
In-Reply-To: <1419275322-29811-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1419275322-29811-1-git-send-email-ard.biesheuvel@linaro.org>
 <1419275322-29811-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150106091322.GG3163@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Dec, at 07:08:36PM, Ard Biesheuvel wrote:
> To prevent device drivers from attaching to device or memory regions
> owned by the firmware, register all UEFI reserved regions in the iomem
> resource table at init time.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/efi.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)

Looks nice.

Just curious, have you actually seen drivers trying to claim these
regions?

-- 
Matt Fleming, Intel Open Source Technology Center
