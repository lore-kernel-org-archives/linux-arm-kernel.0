From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 4 Jul 2012 05:36:47 +0000
Subject: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
In-Reply-To: <4FF30B4B.8060203@ti.com>
References: <cover.1340778002.git.afzal@ti.com>
 <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com>
 <20120627145844.GL3483@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com>
 <20120628123207.GG19842@atomide.com> <4FEC89B9.3090404@ti.com>
 <20120702063651.GO4202@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A1BB7@DBDE01.ent.ti.com>
 <4FF1DA5F.9000409@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A22B7@DBDE01.ent.ti.com>
 <4FF30B4B.8060203@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9A2B0C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon, Tony,

On Tue, Jul 03, 2012 at 20:40:03, Hunter, Jon wrote:

> So we have 2 options here ...
> 
> 1. Use the HWMOD_INIT_NO_RESET for now and your updated version of this
> patch
> 2. See if there is a gpio available to control the OneNAND reset on the
> n900.
> 
> Do you agree? Any other options?

Yes agree, I am fine either way, unable to see any other option

HWMOD_INIT_NO_RESET is any way required to start driver conversion
as both new & old interface needs to be supported till all machines
are converted to use the new driver interface as well as at least
till all machines are made independent of bootloader w.r.t GPMC

As of now I feel we should go with option 1

If we need to go with option 2, (assuming OneNAND reset is solution
to the problem) all machines that is configured for sync mode
presently (n8x0, rx51, rm680) has to be made intelligent to do
OneNAND reset (provided gpio is connected to reset). And for all
these machines including N900 (seems rx51), information on gpio pin
connected to reset (if at all connected) and the way to do reset is
required, which I am so far unable to get. Once this information
could be obtained, I can make the patch and then need help from
someone who has the board to test it

Regards
Afzal
