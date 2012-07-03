From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Jul 2012 17:12:11 +0200
Subject: [PATCH 1/9] clocksource: time-armada-370-xp: Marvell Armada
 370/XP SoC timer driver
In-Reply-To: <1341243574-3258-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1341243574-3258-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20120703151211.GE17534@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +{
> +	u32 u;
> +	struct device_node *np;
> +	unsigned int timer_clk;
> +	int ret;
> +	np = of_find_compatible_node(NULL, NULL, "marvell,timer");

Hi Thomas

"marvell,timer" is too generic. I would suggest using
marvell,armada-370-xp-timer, the same prefix as for the system
controller. It allows us to extend the code to handle Orion platforms,
in the same way the system controller does.

   Andrew
