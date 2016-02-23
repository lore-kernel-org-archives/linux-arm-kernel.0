From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Feb 2016 10:16:42 +0000
Subject: [PATCH] arm64: move brk immediate argument definitions to
 separate header
In-Reply-To: <1456214205-18743-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456214205-18743-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160223101642.GB3966@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 08:56:45AM +0100, Ard Biesheuvel wrote:
> Instead of reversing the header dependency between asm/bug.h and
> asm/debug-monitors.h, split off the brk instruction immediate value
> defines into a new header asm/brk-imm.h, and include it from both.
> 
> This solves the circular dependency issue that prevents BUG() from
> being used in some header files, and keeps the definitions together.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/brk-imm.h        | 25 +++++++++++++++++++++++++
>  arch/arm64/include/asm/bug.h            |  2 +-
>  arch/arm64/include/asm/debug-monitors.h | 14 +-------------
>  3 files changed, 27 insertions(+), 14 deletions(-)
>  create mode 100644 arch/arm64/include/asm/brk-imm.h

Acked-by: Will Deacon <will.deacon@arm.com>

Will
