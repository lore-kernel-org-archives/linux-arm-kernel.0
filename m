From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 29 Feb 2016 18:36:36 +0000
Subject: [PATCH v2 2/2] arm64: mm: treat memstart_addr as a signed quantity
In-Reply-To: <1456505834-8638-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1456505834-8638-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456505834-8638-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160229183636.GF7935@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 05:57:14PM +0100, Ard Biesheuvel wrote:
> Commit c031a4213c11 ("arm64: kaslr: randomize the linear region")
> implements randomization of the linear region, by subtracting a random
> multiple of PUD_SIZE from memstart_addr. This causes the virtual mapping
> of system RAM to move upwards in the linear region, and at the same time
> causes memstart_addr to assume a value which may be negative if the offset
> of system RAM in the physical space is smaller than its offset relative to
> PAGE_OFFSET in the virtual space.
> 
> Since memstart_addr is effectively an offset now, redefine its type as s64
> so that expressions involving shifting or division preserve its sign.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied. Thanks.

-- 
Catalin
