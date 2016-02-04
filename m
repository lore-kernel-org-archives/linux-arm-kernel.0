From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 4 Feb 2016 15:13:04 +0000
Subject: [PATCH v5sub2 1/8] arm64: add support for module PLTs
In-Reply-To: <1454332178-4414-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454332178-4414-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160204151303.GB6076@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 02:09:31PM +0100, Ard Biesheuvel wrote:
> This adds support for emitting PLTs at module load time for relative
> branches that are out of range. This is a prerequisite for KASLR, which
> may place the kernel and the modules anywhere in the vmalloc area,
> making it more likely that branch target offsets exceed the maximum
> range of +/- 128 MB.

Any downside to trying to keep the kernel+modules coupled together so
that we avoid the PLT?

-- 
Catalin
