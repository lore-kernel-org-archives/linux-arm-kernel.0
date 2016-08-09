From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 9 Aug 2016 10:03:31 -0300
Subject: [PATCH 1/1] irqchip: irq-gic: forward SGI to itself for cortex-a7
 single core
In-Reply-To: <57A99A4A.6010301@arm.com>
References: <20160808105026.GA12649@leverpostej>
 <HE1PR04MB1450C6BE844A31C95CEE3BE18B1B0@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <20160808130754.GB12649@leverpostej> <20160808132847.GB17680@shlinux2>
 <20160808134842.GE12649@leverpostej> <20160808145916.0924e868@arm.com>
 <20160809034613.GB31105@shlinux2> <20160809063401.3117dc94@arm.com>
 <20160809055701.GC31105@shlinux2> <20160809075930.529f98ca@arm.com>
 <20160809071821.GD31105@shlinux2> <57A99A4A.6010301@arm.com>
Message-ID: <CAOMZO5D0Yt9Y-hy2YzTpOr40J=4++r+8LU3ezmsB+1FBFQw1Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Tue, Aug 9, 2016 at 5:54 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> From 23ba8b645d219e333a10224d74fb5d8d75d67de2 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <marc.zyngier@arm.com>
> Date: Tue, 9 Aug 2016 07:50:44 +0100
> Subject: [PATCH] irqchip/gic: Allow self-SGIs for SMP on UP configurations
>
> On systems where a single CPU is present, the GIC may not support
> having SGIs delivered to a target list. In that case, we use the
> self-SGI mechanism to allow the interrupt to be delivered locally.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

This fixes the halt after running 'reboot' on mx6ul, thanks:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>

Please also Cc stable when you submit this formally.

Thanks
