From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 27 Jan 2013 16:41:04 +0100
Subject: [PATCH] clk: mvebu: Do not gate ge0/1 and runit clocks on Kirkwood
In-Reply-To: <20130127152837.GI29973@lunn.ch>
References: <1359226864-28811-1-git-send-email-gmbnomis@gmail.com>
 <20130126235037.GV1758@titan.lakedaemon.net>
 <20130127013131.GA2400@schnuecks.de> <5104FE5F.2040804@gmail.com>
 <20130127105654.GA23127@schnuecks.de> <51050B9E.8000605@gmail.com>
 <20130127152837.GI29973@lunn.ch>
Message-ID: <20130127164104.1b2e66e6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Sun, 27 Jan 2013 16:28:37 +0100, Andrew Lunn wrote:

> I've been thinking the same, store the MAC address before turning the
> clock off and restore it when enabling the clock. We have a need for
> special clocks on kirkwood anyway for turning off the sata and pcie
> PHYs. So adding special clocks for ethernet is not too big a deal.

At least on Armada 370/XP, U-Boot passes the MAC address through a
special ATAG. Willy Tarreau has written some code to read this special
ATAG and feed it into the Device Tree, so that we get the MAC address
as set by U-Boot. I unfortunately haven't had the time to look at
Willy's code and push it, but it does seem like an interesting solution.

Are you interested?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
