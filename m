From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Jun 2014 18:12:33 +0200
Subject: [PATCH] ARM: mvebu: Enable SCU Speculative linefills to L2 for
 Armada 375/38x
In-Reply-To: <53AC37A4.8090306@free-electrons.com>
References: <1403790178-23902-1-git-send-email-gregory.clement@free-electrons.com>
 <20140626165230.374f285e@free-electrons.com>
 <53AC37A4.8090306@free-electrons.com>
Message-ID: <20140626161233.GD18520@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > A broader question is: if this feature is generic to all Cortex-A9, why
> > not offer a function in smp_scu.c to enable it? It seems weird to have
> > the offset and bit definitions for something as generic as the SCU
> > present deep into a Marvell-specific file.
> 
> I have no strong opinion on it, and I also thoough about adding a function
> in smp_scu.c but when you are looking at the usage of SCU is the kernel
> the other SOC manipulate it directly.

Hi Gregory

Is that just cult cargo coding? Maybe now is the time to refactor this
into one central location?

     Andrew
