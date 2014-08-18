From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 17:40:56 +0100
Subject: [PATCH] arm64: audit: Fix build for audit changes
In-Reply-To: <1408285597-30913-1-git-send-email-broonie@kernel.org>
References: <1408285597-30913-1-git-send-email-broonie@kernel.org>
Message-ID: <20140818164056.GB24600@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 17, 2014 at 03:26:37PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Commit 3efe33f5d2 (audit: x86: drop arch from __audit_syscall_entry()
> interface) removed the arch parameter from __audit_syscall_entry() and
> updated the only current user in mainline but this breaks the ARMv8 audit
> code that has been added in -next. Fix this by making the equivalent
> update to ARMv8.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

BTW, we plan to revert the temporary hack to avoid this error with
defconfig. So the above patch should go into next on top of the other
patches from Eric changing the function prototype.

Thanks,

Catalin
