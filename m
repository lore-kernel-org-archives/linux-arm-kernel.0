From: fweimer@redhat.com (Florian Weimer)
Date: Mon, 6 Aug 2018 12:07:48 +0200
Subject: [RFC/PoC PATCH 0/3] arm64: basic ROP mitigation
In-Reply-To: <20180802132133.23999-1-ard.biesheuvel@linaro.org>
References: <20180802132133.23999-1-ard.biesheuvel@linaro.org>
Message-ID: <fef98ede-efe4-eaf2-f314-07b623e9800e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2018 03:21 PM, Ard Biesheuvel wrote:
> The idea is that we can significantly limit the kernel's attack surface
> for ROP based attacks by clearing the stack pointer's sign bit before
> returning from a function, and setting it again right after proceeding
> from the [expected] return address. This should make it much more difficult
> to return to arbitrary gadgets, given that they rely on being chained to
> the next via a return address popped off the stack, and this is difficult
> when the stack pointer is invalid.

Doesn't this break stack unwinding?

Thanks,
Florian
