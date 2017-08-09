From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Aug 2017 18:25:28 +0100
Subject: [PATCH v2 06/16] arm64: entry.S: convert elX_sync
In-Reply-To: <20170728141019.9084-7-james.morse@arm.com>
References: <20170728141019.9084-1-james.morse@arm.com>
 <20170728141019.9084-7-james.morse@arm.com>
Message-ID: <20170809172527.yrkpthrrtqoxi4d7@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Fri, Jul 28, 2017 at 03:10:09PM +0100, James Morse wrote:
> @@ -520,9 +514,16 @@ el1_preempt:
>  el0_sync:
>  	kernel_entry 0
>  	mrs	x25, esr_el1			// read the syndrome register
> +	mrs	x26, far_el1

Just checking, since we are going to access far_el1 even when we get a
syscall, have you noticed any overhead?

-- 
Catalin
