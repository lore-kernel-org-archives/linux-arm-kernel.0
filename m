From: robherring2@gmail.com (Rob Herring)
Date: Thu, 27 Mar 2014 09:15:20 -0500
Subject: [PATCH] arm64: add appropriate asm/unaligned.h
In-Reply-To: <1395927591-20938-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1395927591-20938-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAL_JsqLyZG+z+SNy+++pJ15WeWbTFgDRTfOE9j66wE9kX0F9-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 8:39 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> The generic asm/unaligned.h does not allow unaligned accesses, resulting in all
> invocations of get_unaligned_xxx() and put_unaligned_xxx() to be expanded into
> byte size accesses. On arm64, this is unnecessary, so provide a more permissive
> asm/unaligned.h instead.

Couldn't the generic version learn to use
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS on arches that enable it?

Rob
