From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Apr 2012 12:12:40 +0100
Subject: Bug in v7_coherent_kern_range() ?
In-Reply-To: <4F77C9A6.6080601@freescale.com>
References: <4F77C9A6.6080601@freescale.com>
Message-ID: <20120402111240.GG19011@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 01, 2012 at 04:21:10AM +0100, Huang Shijie wrote:
> But in some unknown situation, cacheflush() failed and one threads
> (assume A) may hung up in the following code:

[...]

> multiqueue0:src D 804cd678 0 7328 5963 0x00000001
> [<804cd678>] (__schedule+0x228/0x760) from [<804d0564>]
> (__down_read+0xa8/0xe0)
> [<804d0564>] (__down_read+0xa8/0xe0) from [<800478c4>]
> (do_page_fault+0xbc/0x480)
> [<800478c4>] (do_page_fault+0xbc/0x480) from [<8003841c>]
> (do_DataAbort+0x34/0x98)
> [<8003841c>] (do_DataAbort+0x34/0x98) from [<8003df10>]
> (__dabt_svc+0x70/0xa0)
> Exception stack(0xbae37ea8 to 0xbae37ef0)
> 7ea0: 31e05000 31e1d000 00000020 0000001f 31e05000 31e1d000
> 7ec0: bfac86b8 31e05000 31e1d000 bae36000 08100075 31e056fc 31e08000
> bae37ef0
> 7ee0: 800424a8 8004a1fc 800f0013 ffffffff
> [<8003df10>] (__dabt_svc+0x70/0xa0) from [<8004a1fc>]
> (v7_coherent_kern_range+0x20/0x80)
> [<8004a1fc>] (v7_coherent_kern_range+0x20/0x80) from [<800424a8>]
> (arm_syscall+0x2a0/0x2c4)
> [<800424a8>] (arm_syscall+0x2a0/0x2c4) from [<8003e500>]
> (ret_fast_syscall+0x0/0x3c)

Please can you try the patch posted here:?

http://lists.arm.linux.org.uk/lurker/message/20111107.173344.f738392e.en.html

If it fixes your problem, please consider giving a tested-by.

Will
