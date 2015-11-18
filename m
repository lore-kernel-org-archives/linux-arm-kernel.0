From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Nov 2015 12:09:41 +0000
Subject: [PATCH] arm64: crypto: reduce priority of core AES cipher
In-Reply-To: <1447675968-21991-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1447675968-21991-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151118120940.GE27495@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 01:12:48PM +0100, Ard Biesheuvel wrote:
> The asynchronous, merged implementations of AES in CBC, CTR and XTS
> modes are preferred when available (i.e., when instantiating ablkciphers
> explicitly). However, the synchronous core AES cipher combined with the
> generic CBC mode implementation will produce a 'cbc(aes)' blkcipher that
> is callable asynchronously as well. To prevent this implementation from
> being used when the accelerated asynchronous implemenation is also
> available, lower its priority to 250 (i.e., below the asynchronous
> module's priority of 300).
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied. Thanks.

-- 
Catalin
