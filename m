From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 13 May 2016 13:47:17 +0200
Subject: [PATCH V2 1/2] drivers: i2c: qup: Fix broken dma when
 CONFIG_DEBUG_SG is enabled
In-Reply-To: <1462534274-28925-2-git-send-email-sricharan@codeaurora.org>
References: <1462534274-28925-1-git-send-email-sricharan@codeaurora.org>
 <1462534274-28925-2-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160513114716.GI1778@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 06, 2016 at 05:01:13PM +0530, Sricharan R wrote:
> With CONFIG_DEBUG_SG is enabled and when dma mode is used, below dump is seen, 
> 
> ------------[ cut here ]------------ 
> kernel BUG at include/linux/scatterlist.h:140! 
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP 
> Modules linked in: 
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.0-00459-g9f087b9-dirty #7 
> Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT) 
> task: ffffffc036868000 ti: ffffffc036870000 task.ti: ffffffc036870000 
> PC is at qup_sg_set_buf.isra.13+0x138/0x154 
> LR is at qup_sg_set_buf.isra.13+0x50/0x154 
> pc : [<ffffffc0005a0ed8>] lr : [<ffffffc0005a0df0>] pstate: 60000145 
> sp : ffffffc0368735c0 
> x29: ffffffc0368735c0 x28: ffffffc036873752 
> x27: ffffffc035233018 x26: ffffffc000c4e000 
> x25: 0000000000000000 x24: 0000000000000004 
> x23: 0000000000000000 x22: ffffffc035233668 
> x21: ffffff80004e3000 x20: ffffffc0352e0018 
> x19: 0000004000000000 x18: 0000000000000028 
> x17: 0000000000000004 x16: ffffffc0017a39c8 
> x15: 0000000000001cdf x14: ffffffc0019929d8 
> x13: ffffffc0352e0018 x12: 0000000000000000 
> x11: 0000000000000001 x10: 0000000000000001 
> x9 : ffffffc0012b2d70 x8 : ffffff80004e3000 
> x7 : 0000000000000018 x6 : 0000000030000000 
> x5 : ffffffc00199f018 x4 : ffffffc035233018 
> x3 : 0000000000000004 x2 : 00000000c0000000 
> x1 : 0000000000000003 x0 : 0000000000000000 
> 
> Process swapper/0 (pid: 1, stack limit = 0xffffffc036870020) 
> Stack: (0xffffffc0368735c0 to 0xffffffc036874000) 
> 
> Change allocation of sg buffers from dma_coherent memory to kzalloc 
> to fix the issue. 

This description describes what you do. But not why it is the correct
solution to the OOPS. The OOPS  neither describes it. Please add some
more explanation.

> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Reviewed-by: Andy Gross <andy.gross@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160513/800326b8/attachment.sig>
