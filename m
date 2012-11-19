From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 19 Nov 2012 16:44:57 +0000
Subject: [PATCH] ARM: Kconfig: Do not select ARCH_VEXPRESS on ARCH_MULTI_V7
In-Reply-To: <1353343080-19220-1-git-send-email-fabio.estevam@freescale.com>
References: <1353343080-19220-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1353343497.3303.34.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-19 at 16:38 +0000, Fabio Estevam wrote:
> Booting a kernel on a mx53qsb board (built with imx_v6_v7_defconfig) leads to:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000008
> pgd = 80004000
> [00000008] *pgd=00000000
> Internal error: Oops: 805 [#1] SMP ARM
> Modules linked in:
> CPU: 0    Not tainted  (3.7.0-rc5-next-20121115+ #715)
> PC is at vexpress_sysreg_init_leds+0x30/0xb8
> LR is at do_one_initcall+0x3c/0x190
> pc : [<8065e170>]    lr : [<800086a0>]    psr: 60000153
> sp : df855ef0  ip : df855f18  fp : df855f14
> r10: 00000000  r9 : 8067eb5c  r8 : 8065e140
> r7 : 80711cac  r6 : 806c2cc0  r5 : 00000000  r4 : 80673850
> r3 : 00000000  r2 : 00000000  r1 : df854000  r0 : 8065e140
> ...

It's a bug in vexpress-sysreg driver. 3 hours ago I've posted patch
removing this code...

https://patchwork.kernel.org/patch/1764801/

Apologies about causing the issue in the first place.

Pawel
