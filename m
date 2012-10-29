From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 29 Oct 2012 11:03:03 +0100
Subject: [PATCH v3 3/4] arm: mvebu: move irq controller driver to
 drivers/irqchip
In-Reply-To: <508E4EB3.5060901@gmail.com>
References: <1351462748-5224-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351462748-5224-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <508E49E0.8050606@gmail.com> <20121029102436.504d5053@skate>
 <508E4EB3.5060901@gmail.com>
Message-ID: <20121029100303.GD20377@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 10:38:59AM +0100, Sebastian Hesselbarth wrote:
> On 10/29/2012 10:24 AM, Thomas Petazzoni wrote:
> >>using ARCH_MVEBU for enabling irq-armada-370-xp here will lead to
> >>incompatibilities with Orion SoCs when they move over to ARCH_MVEBU.
> >
> >Not really: the driver is probed depending on the DT compatible string.
> >So we can perfectly have two irqchip drivers being enabled on
> >ARCH_MVEBU.
> 
> I agreed but this will always build irq-armada-370-xp into the kernel
> although I maybe want a orion-only kernel. Although multi-platform will
> be great for ARM, I doubt that every kernel will be multi-platform?

Actually, there are multiple multi-platform kernels, kirkwood is v5
where as 370/XP is v6. So a kirkwood build will not need
irq-armada-370-xp.

	Andrew
