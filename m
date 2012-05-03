From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 May 2012 13:59:55 +0100
Subject: [PATCH v5] ARM: cache-l2x0.c: save the final aux ctrl value
 for resuming
In-Reply-To: <1336046857-24133-1-git-send-email-ylmao@marvell.com>
References: <1336046857-24133-1-git-send-email-ylmao@marvell.com>
Message-ID: <20120503125955.GE27872@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 01:07:37PM +0100, Yilu Mao wrote:
> There is a bug if l2x0 controller has been enabled when calling
> l2x0_init, the aux ctrl register will not be saved in l2x0_saved_regs.
> Therefore we will use uninitialized l2x0_saved_regs.aux_ctrl for
> resuming later.
> 
> In this patch, the aux ctrl value is read and saved after it is
> initialized. So we have the real value being set for resuming.
> 
> Signed-off-by: Yilu Mao <ylmao@marvell.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
