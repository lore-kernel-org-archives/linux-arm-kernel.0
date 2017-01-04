From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 4 Jan 2017 11:49:12 +0100
Subject: [PATCH v3] ARM: dts: turris-omnia: add support for ethernet switch
In-Reply-To: <20170103193501.4827-1-uwe@kleine-koenig.org>
References: <20170103152107.GA32450@lunn.ch>
 <20170103193501.4827-1-uwe@kleine-koenig.org>
Message-ID: <e1dae939-e209-eccc-00df-b996d03cb8db@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Am 03.01.2017 um 20:35 schrieb Uwe Kleine-K?nig:
> The Turris Omnia features a Marvell MV88E6176 ethernet switch. Add it to
> the dts.
> 
> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>

It's still not working for me on next-20170104 with this v3.
Are there any other patches needed?

Should all ports LAN0-LAN4 work with the commented-out second cpu node?

I've been using the WAN port (eth2) just fine. (=eth1 in OpenWrt)

With this patch, eth0 and eth1 are shown as UP by default. If however I
enslave eth0 and eth1 in a br-lan bridge, as seen under OpenWrt for
eth0+eth2, then eth1 is DOWN while eth0 remains UP, and br-lan remains
DOWN. Same issue if I drop eth0 from the bridge - after a reboot eth1 is
UP but br-lan is still DOWN.
I had to manually enable CONFIG_BRIDGE, so maybe I'm missing more kernel
options? Or did you simply not try using a bridge?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
