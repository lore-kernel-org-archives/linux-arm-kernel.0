From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Aug 2012 15:38:12 +0000
Subject: [PATCH v2] ARM: io: avoid writeback addressing modes for __raw_
 accessors
In-Reply-To: <1345557059-6922-1-git-send-email-will.deacon@arm.com>
References: <1345557059-6922-1-git-send-email-will.deacon@arm.com>
Message-ID: <201208211538.13113.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 August 2012, Will Deacon wrote:
> 
> Data aborts taken to hyp mode do not provide a valid instruction
> syndrome field in the HSR if the faulting instruction is a memory
> access using a writeback addressing mode.
> 
> For hypervisors emulating MMIO accesses to virtual peripherals, taking
> such an exception requires disassembling the faulting instruction in
> order to determine the behaviour of the access. Since this requires
> manually walking the two stages of translation, the world must be
> stopped to prevent races against page aging in the guest, where the
> first-stage translation is invalidated after the hypervisor has
> translated to an IPA and the physical page is reused for something else.
> 
> This patch avoids taking this heavy performance penalty when running
> Linux as a guest by ensuring that our I/O accessors do not make use of
> writeback addressing modes.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Nicolas Pitre <nico@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
