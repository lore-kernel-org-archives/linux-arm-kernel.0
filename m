From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Jan 2018 10:04:27 +0000
Subject: [PATCH v2 2/2] arm64: Implement branch predictor hardening for
 Falkor
In-Reply-To: <1515447068-20977-2-git-send-email-shankerd@codeaurora.org>
References: <1515447068-20977-1-git-send-email-shankerd@codeaurora.org>
 <1515447068-20977-2-git-send-email-shankerd@codeaurora.org>
Message-ID: <20180109100426.GE4297@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 03:31:08PM -0600, Shanker Donthineni wrote:
> Falkor is susceptible to branch predictor aliasing and can
> theoretically be attacked by malicious code. This patch
> implements a mitigation for these attacks, preventing any
> malicious entries from affecting other victim contexts.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
> Changes since v1:
>   Corrected typo to fix the compilation errors if HARDEN_BRANCH_PREDICTOR=n
> 
> This patch requires FALKOR MIDR which is available in upstream v4.15-rc7
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64?h=v4.15-rc7&id=c622cc013cece073722592cff1ac6643a33b1622 ans also
>   attached this v2 patch series.

Please resend this as a fixup on top of for-next/core. It might make the
most sense to queue that at -rc1, after the MIDR change has already landed
in mainline.

Will
