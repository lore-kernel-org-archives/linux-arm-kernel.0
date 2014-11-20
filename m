From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Nov 2014 16:30:38 +0000
Subject: [PATCH v5 3/6] arm64: Add framework for legacy instruction
 emulation
In-Reply-To: <1416310887-14649-4-git-send-email-punit.agrawal@arm.com>
References: <1416310887-14649-1-git-send-email-punit.agrawal@arm.com>
 <1416310887-14649-4-git-send-email-punit.agrawal@arm.com>
Message-ID: <20141120163037.GC5447@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 11:41:24AM +0000, Punit Agrawal wrote:
> Typically, providing support for legacy instructions requires
> emulating the behaviour of instructions whose encodings have become
> undefined. If the instructions haven't been removed from the
> architecture, there maybe an option in the implementation to turn
> on/off the support for these instructions.
> 
> Create common infrastructure to support legacy instruction
> emulation. In addition to emulation, also provide an option to support
> hardware execution when supported. The default execution mode (one of
> undef, emulate, hw exeuction) is dependent on the state of the
> instruction (deprecated or obsolete) in the architecture and
> can specified at the time of registering the instruction handlers. The
> runtime state of the emulation can be controlled by writing to
> individual nodes in sysctl. The expected default behaviour is
> documented as part of this patch.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
