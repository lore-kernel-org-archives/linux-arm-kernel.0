From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Jan 2014 11:21:55 +0000
Subject: [RFC PATCH 0/3] Add support for dwarf compat mode unwinding
In-Reply-To: <1390252922-25889-1-git-send-email-jean.pihet@linaro.org>
References: <1390252922-25889-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <20140121112155.GI30706@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 09:21:59PM +0000, Jean Pihet wrote:
> In the case of unwinding the debug info from a binary that has a different
> address size than the current native platform, it is needed to record
> it in the address space struct, in order to correctly parse the debug
> info later. This mode is known as compat mode.

Terminology issues here.... compat mode isn't really that well defined, but
typically involves a different kernel ABI. That doesn't necessarily affect
the address size.

> This is the case when e.g. profiling an ARMv7 binary that runs on an
> ARMv8 (aka AARCH64) platform.

ARMv8 != AArch64

Will
