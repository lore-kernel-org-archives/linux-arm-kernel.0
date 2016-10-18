From: davem@davemloft.net (David Miller)
Date: Tue, 18 Oct 2016 14:14:37 -0400 (EDT)
Subject: [PATCH v3 0/4] support smc91x on mainstone and devicetree
In-Reply-To: <1476733532-29716-1-git-send-email-robert.jarzmik@free.fr>
References: <1476733532-29716-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20161018.141437.2029098820682032692.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Mon, 17 Oct 2016 21:45:28 +0200

> This serie aims at bringing support to mainstone board on a device-tree based
> build, as what is already in place for legacy mainstone.
> 
> The bulk of the mainstone "specific" behavior is that a u16 write doesn't work
> on a address of the form 4*n + 2, while it works on 4*n.
> 
> The legacy workaround was in SMC_outw(), with calls to
> machine_is_mainstone(). These calls don't work with a pxa27x-dt machine type,
> which is used when a generic device-tree pxa27x machine is used to boot the
> mainstone board.
> 
> Therefore, this serie enables the smc91c111 adapter of the mainstone board to
> work on a device-tree build, exaclty as it's been working for years with the
> legacy arch/arm/mach-pxa/mainstone.c definition.
> 
> As a sum up, this extends an existing mechanism to device-tree based pxa platforms.

Series applied, thanks.
