From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Feb 2013 23:19:37 -0300
Subject: [PATCH 1/1] net: fec: fix crash at mx53 qsb board
In-Reply-To: <1361408848-14118-1-git-send-email-Frank.Li@freescale.com>
References: <1361408848-14118-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <CAOMZO5CiBFBUEFGArceE=7Q25B7ZAj4GKZgGF0n+4KM1oCJjBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 20, 2013 at 10:07 PM, Frank Li <Frank.Li@freescale.com> wrote:
> Unable to handle kernel NULL pointer dereference at virtual address 00000002
> pgd = 80004000
> [00000002] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 0    Not tainted  (3.8.0-rc7-next-20130215+ #346)
> PC is at fec_enet_interrupt+0xd0/0x348
> LR is at fec_enet_interrupt+0xb8/0x348
> pc : [<80372b7c>]    lr : [<80372b64>]    psr: 60000193
> sp : df855c20  ip : df855c20  fp : df855c74
> r10: 00000516  r9 : 1c000000  r8 : 00000000
> r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : df9b7800
> r3 : df9b7df4  r2 : 00000000  r1 : 00000000  r0 : df9b7d34
>
> It is possible that issue a irq between request_irq and fec_enet_init.
> Irq handle will be called but driver data structure is not ready yet.
>
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
