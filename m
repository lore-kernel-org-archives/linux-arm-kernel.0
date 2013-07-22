From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 22 Jul 2013 10:05:00 -0700
Subject: [PATCH 4/4] ARM: set --be8 when linking modules
In-Reply-To: <1374510833-25716-5-git-send-email-ben.dooks@codethink.co.uk>
References: <1374510833-25716-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374510833-25716-5-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130722170500.GC19639@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22, Ben Dooks wrote:
> To avoid having to make every text section swap the instruction order
> of all instructions, make sure modules are built also built with --be8
> (as is the current kernel final link).
> 
> If we do not do this, we would end up having to swap all instructions
> when loading a module, instead of just the instructions that we are
> applying ELF relocations to.
> 

If someone tries to load a be8 module on a non-be8 kernel will it
still work? Or should we add an extra version magic string in
asm/module.h to prevent that?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
