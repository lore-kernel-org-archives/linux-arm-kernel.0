From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Mar 2016 18:15:28 +0000
Subject: [PATCH] arm64: enable CONFIG_DEBUG_RODATA by default
In-Reply-To: <1457014259-32015-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1457014259-32015-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160303181528.GB2074@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 03:10:59PM +0100, Ard Biesheuvel wrote:
> In spite of its name, CONFIG_DEBUG_RODATA is an important hardening feature
> for production kernels, and distros all enable it by default in their
> kernel configs. However, since enabling it used to result in more granular,
> and thus less efficient kernel mappings, it is not enabled by default for
> performance reasons.
> 
> However, since commit 2f39b5f91eb4 ("arm64: mm: Mark .rodata as RO"), the
> various kernel segments (.text, .rodata, .init and .data) are already
> mapped individually, and the only effect of setting CONFIG_DEBUG_RODATA is
> that the existing .text and .rodata mappings are updated late in the boot
> sequence to have their read-only attributes set, which means that any
> performance concerns related to enabling CONFIG_DEBUG_RODATA are no longer
> valid.
> 
> So from now on, make CONFIG_DEBUG_RODATA default to 'y'

Patch applied. If we later get a command line option as Kees mentioned,
I'm happy to drop this option entirely.

-- 
Catalin
