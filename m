From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Mar 2014 17:39:40 +0000
Subject: [PATCH] arm64: enable generic CPU feature modalias matching for
 this architecture
In-Reply-To: <1393895404-14776-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1393895404-14776-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140314173940.GL18126@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 01:10:04AM +0000, Ard Biesheuvel wrote:
> +static inline bool cpu_have_feature(unsigned int num)
> +{
> +	return !!(elf_hwcap & (1UL << num));
> +}

Do we still need !! if the return type is bool? (I can remove it myself,
no need to resend the patch)

-- 
Catalin
