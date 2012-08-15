From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 15:56:46 +0000
Subject: [PATCH v2 29/31] arm64: Miscellaneous header files
In-Reply-To: <1344966752-16102-30-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-30-git-send-email-catalin.marinas@arm.com>
Message-ID: <201208151556.46426.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Catalin Marinas wrote:

> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> new file mode 100644
> index 0000000..dc50de7
> --- /dev/null
> +++ b/arch/arm64/include/asm/cmpxchg.h

> +	default:
> +		__bad_cmpxchg(ptr, size);
> +		oldval = 0;
> +	}

I did not see a definition for __bad_cmpxchg but I may have missed that.
Please make sure that none exists, or just use BUILD_BUG_ON().

	Arnd
