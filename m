From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jan 2017 12:37:05 +0000
Subject: [PATCH] arm64: head.S: fix up stale comments
In-Reply-To: <1483972315-12782-1-git-send-email-mark.rutland@arm.com>
References: <1483972315-12782-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170110123705.GF21598@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 02:31:55PM +0000, Mark Rutland wrote:
> In commit 23c8a500c24d02dd ("arm64: kernel: use ordinary return/argument
> register for el2_setup()"), we stopped using w20 as a global stash of
> the boot mode flag, and instead pass this around in w0 as a function
> parameter.
> 
> Unfortunately, we missed a couple of comments, which still refer to the
> old convention of using w20/x20.
> 
> This patch fixes up the comments to describe the code as it currently
> works.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/head.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied for 4.11 with Ard's ack.

Will
