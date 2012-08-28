From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 28 Aug 2012 11:31:37 +0200
Subject: [PATCH] mtd: orion_nand: remove <mach/hardware.h> include
In-Reply-To: <20120828091139.GC31704@lunn.ch>
References: <20120816183708.GT22226@titan.lakedaemon.net>
 <1346110528-30858-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1346110528-30858-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120828091139.GC31704@lunn.ch>
Message-ID: <CABJ1b_QgJU_xLL2Z=-r_hs51O+d4W+oLZPPf9-6UmeO5B+chPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/28/12, Andrew Lunn <andrew@lunn.ch> wrote:
> One other driver you might want to look at is:
>
> drivers/watchdog/orion_wdt.c
> It uses <mach/bridge-regs.h>

Andrew, Thomas,

both current watchdog and timer are using the bridge-regs to clear the
interrupt cause. On orion the cause register is located in bridge-regs.
>From the work on timer together with Gregory, I expect Armada 370/XP
to have the watchdog cause bit also within timer registers.

Sebastian
