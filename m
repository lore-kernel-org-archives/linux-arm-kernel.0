From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Feb 2014 12:23:34 +0000
Subject: [PATCH] arm64: add workaround for ambiguous C99 stdint.h types
In-Reply-To: <1390768248-1688-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1390768248-1688-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140217122334.GA19102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Sun, Jan 26, 2014 at 08:30:48PM +0000, Ard Biesheuvel wrote:
> In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
> for ambiguous C99 stdint.h types"), this patch redefines the macros that
> are used in stdint.h so its definitions of uint64_t and int64_t are
> compatible with those of the kernel.
> 
> In order to do so, drop types.h from generic-y and create a specific arm64
> version identical to the generic one with just the #define overrides added.

I tried but still can't get what this patch is about. Do the
linux/types.h types ever get to user space? We have uapi/linux/types.h
for this.

Can you give an example of where this is needed? Which source file
includes both stdint.h and linux/types.h (non-uapi version)?

-- 
Catalin
