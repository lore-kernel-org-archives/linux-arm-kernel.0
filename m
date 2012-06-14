From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Jun 2012 01:39:58 -0700
Subject: [PATCH v5 04/14] ARM: OMAP2+: gpmc: minimal driver support
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E99952D@DBDE01.ent.ti.com>
References: <4FD6586A.9060706@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997E2A@DBDE01.ent.ti.com>
 <4FD782F7.9010003@ti.com> <20120613120717.GP12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998E43@DBDE01.ent.ti.com>
 <20120613134032.GW12766@atomide.com>
 <20120613134408.GY12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998F2F@DBDE01.ent.ti.com>
 <20120614063524.GB12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99952D@DBDE01.ent.ti.com>
Message-ID: <20120614083957.GC12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal <afzal@ti.com> [120613 23:44]:
> Hi Tony,
> 
> On Thu, Jun 14, 2012 at 12:05:25, Tony Lindgren wrote:
> > * Mohammed, Afzal <afzal@ti.com> [120613 06:56]:
> 
> 
> > > Or you meant, even there read revision register ?
> > 
> > Yeah that should be fine as this really should only happen
> > during init and whatever revision specific features can
> > be initialized for GPMC.
> 
> Sorry, I got confused, we need revision to be available while setting
> time also, so you meant to store it as a variable or read revision
> at probe as well as during setting time ?

You can set up GPMC specific flags during init, something like
OMAP_GPMC_HAS_XYZ, or you can set up function pointers if only
some features are available on some revisions.

Regards,

Tony
