From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 31 Jul 2015 09:52:59 +0200
Subject: [RFC] arm64:change jump_label to use branch instruction, not use
 NOP instr
In-Reply-To: <94E2034B-9DE4-4ADF-8B2F-197D38A363CF@gmail.com>
References: <94E2034B-9DE4-4ADF-8B2F-197D38A363CF@gmail.com>
Message-ID: <20150731075259.GR25159@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 03:41:37PM +0800, yalin wang wrote:
> This change a little arch_static_branch(), use b . + 4 for false
> return, why? According to aarch64 TRM, if both source and dest
> instr are branch instr, can patch the instr directly, don't need
> all cpu to do ISB for sync, this means we can call
> aarch64_insn_patch_text_nosync() during patch_text(),
> will improve the performance when change a static_key.

This doesn't parse.. What?

Also, this conflicts with the jump label patches I've got.
