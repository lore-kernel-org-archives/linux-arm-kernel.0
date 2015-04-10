From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Apr 2015 22:08:38 +0200
Subject: [PATCH v2] crypto/arm: accelerated SHA-512 using ARM generic ASM
 and NEON
In-Reply-To: <1428676148-28210-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1428676148-28210-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <5553652.sur4tr0YJi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 April 2015 16:29:08 Ard Biesheuvel wrote:
> +#if __ARM_MAX_ARCH__>=7
> +.arch  armv7-a
> +.fpu   neon
> +
> 

This will cause a build failure on an ARMv7-M build, which is incompatible
with .arch  armv7-a and .fpu   neon.

	Arnd
