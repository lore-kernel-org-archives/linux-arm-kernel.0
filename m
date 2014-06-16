From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 Jun 2014 10:31:19 +0100
Subject: [PATCH] arm64/crypto: fix and improve GHASH secure hash
 implementation
In-Reply-To: <1402584187-17114-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1402584187-17114-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140616093119.GB3971@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 03:43:07PM +0100, Ard Biesheuvel wrote:
> This fixes a bug in the arm64 GHASH implementation, and switches to a faster,
> polynomial multiplication based reduction instead of one that uses
> shifts and rotates.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> This is a bug fix and a performance optimization in a single patch. As the code
> has never worked correctly and was merged just a couple of days ago, I am
> assuming this is OK but if anyone would prefer the bug fix separately, I'm happy
> to split them as well.

I can push a performance optimisation patch as well but I would prefer
to separate the bug-fixing part. Could you please also describe what the
bug was for future reference?

Thanks.

-- 
Catalin
