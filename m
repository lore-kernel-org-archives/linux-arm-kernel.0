From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 16:44:38 +0200
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <4FB269CB.4080804@gmail.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515091838.GC6820@lunn.ch> <4FB22727.6090406@codethink.co.uk>
 <20120515115511.75ece9c3@skate> <4FB269CB.4080804@gmail.com>
Message-ID: <20120515164438.22258885@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 15 May 2012 09:35:55 -0500,
Rob Herring <robherring2@gmail.com> a ?crit :

> Directory location doesn't really have anything to do with what can be
> in a single kernel binary. We will soon be building single images
> across mach directories.

Agreed, but it's not the case right now, and we wanted to submit today
a kernel that boots on both of those SoCs.

The 370 and XP both use the PJ4B core, which is a Marvell
implementation of an ARMv7 compatible core. The 370 has one PJ4B, and
the various XP variants have a choice of 2 or 4 PJ4Bs, and various
other differences. To us, it makes a lot of sense to be able to support
those SoCs together in the same kernel image and in the same directory,
even if both concepts are not directly tied together.

> With some hacks and limitations, Arnd has
> built (not run) omap2+, u8500, imx and one other in a single kernel.
> If there's overlap with dove or other platforms, then they should
> probably all be combined into a single mach directory. One option
> would be make the new mach directory somewhat generic and then later
> move dove or others into the new directory.

This would be one solution.

On the naming side, we are really open to what the community prefers.
We knew there would be quite a bit of discussion around this, because
there's a lot quite a few Marvell SoCs supported in various places, and
it's not obvious what's the right place and name for a new SoC family.

What about making it mach-marvell, which would contain the DT-enabled
SoC support for Marvell SoCs? We can start with 370 and XP today, and
gradually add future SoCs, or even port previous SoCs as they are moved
to support the device tree.

Again we're really open on the solution. Lior from Marvell can give all
the necessary input to explain how the SoC family is organized.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
