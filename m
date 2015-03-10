From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Mar 2015 17:29:35 +0000
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <54FF21BE.2040506@list.ru>
References: <54FF21BE.2040506@list.ru>
Message-ID: <20150310172935.GT8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 07:54:22PM +0300, Stas Sergeev wrote:
> Hello, the patch below is needed for a successful boot on armada-xp.
> 
> 
> -=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-
> This fixes the following crash at boot:
> 
>  Unhandled fault: external abort on non-linefetch (0x808) at 0xf00ca018
>  Internal error: : 808 [#1] SMP ARM
> 
>  CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc1 #3
>  Hardware name: Marvell Armada 370/XP (Device Tree)
>  task: ed41e800 ti: ed43e000 task.ti: ed43e000

Oh ffs, stop trimming down the dumps.  Knowing what the page table entries
were would have been useful to see whether this is an appropriate fix.

We dump information from the kernel for a reason.  That reason is not so
people can cut random bits that they don't think is relevant from it.

NAK until we see the full dump.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
