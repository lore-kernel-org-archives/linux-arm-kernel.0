From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 14:10:29 +0000
Subject: [PATCH 3/4] arm64: move kernel text below PAGE_OFFSET
In-Reply-To: <1427125016-3873-4-git-send-email-ard.biesheuvel@linaro.org>
References: <20150317164353.GN23340@leverpostej>
 <1427125016-3873-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150325141029.GC26903@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 04:36:55PM +0100, Ard Biesheuvel wrote:
> This moves the virtual mapping of the kernel Image down into
> the lower half of the kernel virtual memory range, moving it
> out of the linear mapping.

I wonder whether there would be better code generation with the kernel
address very high, like the top 64MB. Anyway, having it higher allows us
to check some top bits of the address and detect whether it's kernel
text or linear mapping.

-- 
Catalin
