From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 11 Apr 2015 22:43:49 +0200
Subject: [PATCH v2] crypto/arm: accelerated SHA-512 using ARM generic ASM
 and NEON
In-Reply-To: <F30C78C6-9DED-47DE-BB9F-D88F1716B4D1@linaro.org>
References: <1428676148-28210-1-git-send-email-ard.biesheuvel@linaro.org>
 <2845656.4sNJ3XBxnz@wuerfel>
 <F30C78C6-9DED-47DE-BB9F-D88F1716B4D1@linaro.org>
Message-ID: <12435253.sNXyjYQRd4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 11 April 2015 12:27:18 Ard Biesheuvel wrote:
> 
> Ah i see it now. The new Sha256 module as well as the Sha512 i am proposing here both use a single .o containing the !neon and neon implementations, and only expose the latter if KERNEL_MODE_NEON. This way, we can use the exact same .S file ad OpenSSL, which should mean less maintenance burden.
> 
> So your fix seems the most appropriate, even if it means v7m won't be able to use the !neon part either.
> 
> 

Ok, sounds good. If someone wants to change that code to work on ARMv7-M,
they probably want that fix in the openssl version as well, and then we
can update both.

	Arnd
