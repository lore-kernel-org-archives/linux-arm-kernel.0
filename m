From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 17 Nov 2014 10:49:15 +0100
Subject: [PATCH] ARM: mvebu: fix ordering in Armada 370 .dtsi
In-Reply-To: <20141114202200.GI2001@lunn.ch>
References: <1415993776-3469-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20141114202200.GI2001@lunn.ch>
Message-ID: <20141117104915.0c16e554@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Fri, 14 Nov 2014 21:22:00 +0100, Andrew Lunn wrote:

> Humm.
> 
> Now we have things in the right order, we see that the
> system-controller and the clock-gating-controller overlap.
> 
> I know the HW engineers have gone a bit crazy around here, so maybe we
> have no choice?

Not nice indeed. All those "system-level" registers that do not belong
to clearly identified hardware blocks are really a mess. Maybe it's
time to use the 'syscon' infrastructure to deal with those registers?

Unfortunately, due to the major pain caused by DT backward
compatibility, switching completely and properly to syscon is probably
going to be difficult if we don't want to break old Device Tree files.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
