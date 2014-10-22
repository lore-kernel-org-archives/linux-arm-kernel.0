From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 Oct 2014 17:25:49 +0100
Subject: [PATCH] arm64/crypto: use crypto instructions for generating AES
 key schedule
In-Reply-To: <1413962132-19882-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1413962132-19882-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141022162548.GH15370@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 08:15:32AM +0100, Ard Biesheuvel wrote:
> This patch implements the AES key schedule generation using ARMv8
> Crypto Instructions. It replaces the table based C implementation
> in aes_generic.ko, which means we can drop the dependency on that
> module.

I don't really understand the AES stuff but there's something else I
noticed: if you build a kernel with the crypto stuff and run it on an
implementation that does not have the crypto extensions, there does not
seem to be any check for not using these algorithms (or falling back to
the generic implementation). Does the kernel end up with undef faults?

-- 
Catalin
