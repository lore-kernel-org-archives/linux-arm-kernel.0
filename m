From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 26 Jan 2015 17:45:21 +0000
Subject: [PATCH 1/8] arm64: Move proc-macros.S to include/asm
In-Reply-To: <e81815fb841db3ea40ce8e2fd18cf021ec9c6cf7.1421449714.git.geoff@infradead.org>
References: <cover.1421449714.git.geoff@infradead.org>
 <e81815fb841db3ea40ce8e2fd18cf021ec9c6cf7.1421449714.git.geoff@infradead.org>
Message-ID: <20150126174521.GG14048@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
> To allow the assembler macros defined in proc-macros.S to be used outside
> the mm code move the proc-macros.S file from arch/arm64/mm/ to
> arch/arm64/include/asm/ and fix up any preprocessor includes to use the new
> file location.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/include/asm/proc-macros.S | 54 ++++++++++++++++++++++++++++++++++++
>  arch/arm64/mm/cache.S                |  3 +-
>  arch/arm64/mm/proc-macros.S          | 54 ------------------------------------
>  arch/arm64/mm/proc.S                 |  3 +-

Actually, I would just merge proc-macros.S into assembler.h. Not wirth
keeping the former just for a few macros.

-- 
Catalin
