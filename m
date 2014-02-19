From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Feb 2014 09:08:22 +0100
Subject: [PATCH] net: ethernet: remove unneeded dependency of mvneta and
 update help text
In-Reply-To: <20140219101043.5d403398@xhacker>
References: <1392719391-8851-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140218122952.GM7862@titan.lakedaemon.net>
 <20140218134532.7607a616@skate>
 <20140218125206.GN7862@titan.lakedaemon.net>
 <20140218141303.77c77272@skate> <20140219101043.5d403398@xhacker>
Message-ID: <20140219090822.45a207ba@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jisheng Zhang,

On Wed, 19 Feb 2014 10:10:43 +0800, Jisheng Zhang wrote:

> > At this point, I don't expect to see this IP in any other SOCs than
> > Marvell Armada EBU, so I'll resend with a "depends on PLAT_ORION", as I
> 
> This IP is used in Marvell Berlin SoCs too ;)

Ah good to know!

Then when this IP will be enabled on Marvell Berlin SoCs, we can extend
the "depends on PLAT_ORION" to "depends on PLAT_ORION || ARCH_BERLIN".

> But Berlin SoC doesn't have a mbus concept. Currently, we just hack the
> mvneta to configure the mbus window.

We can simply introduce a separate compatible string, and make the
driver behave differently depending on which compatible string was used
to probe the device.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
