From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 Mar 2015 16:47:02 +0000
Subject: [PATCH 1/3] arm64: Don't use is_module_addr in setting page
 attributes
In-Reply-To: <1424902497-32141-2-git-send-email-lauraa@codeaurora.org>
References: <1424902497-32141-1-git-send-email-lauraa@codeaurora.org>
 <1424902497-32141-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <20150304164701.GY28951@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 02:14:55PM -0800, Laura Abbott wrote:
> 
> The set_memory_* functions currently only support module
> addresses. The addresses are validated using is_module_addr.
> That function is special though and relies on internal state
> in the module subsystem to work properly. At the time of
> module initialization and calling set_memory_*, it's too early
> for is_module_addr to work properly so it always returns
> false. Rather than be subject to the whims of the module state,
> just bounds check against the module virtual address range.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Not sure which tree this would be merged through, so:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I can pick up the arm64 patch and the module.c one with Rusty's ack (as
for the arm one, I think it could go in via rmk's patch system).

-- 
Catalin
