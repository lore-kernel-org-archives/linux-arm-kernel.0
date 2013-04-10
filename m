From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Apr 2013 10:07:39 -0700
Subject: [RFC PATCH 3/3] ARM: OMAP2+: Add command line parameter for
 debugSS module control
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC4A236@DBDE01.ent.ti.com>
References: <hvaibhav@ti.com>
 <1362396957-30113-4-git-send-email-hvaibhav@ti.com>
 <20130408172936.GQ10155@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EC47BB2@DBDE01.ent.ti.com>
 <20130409163459.GJ10155@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EC4A236@DBDE01.ent.ti.com>
Message-ID: <20130410170737.GA10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [130409 22:16]:
> Agreed on making it as a module.
> 
> But do you think we should allow it as a loadable module (M) as well, 
> as user will loose Connectivity to JTAG during boot.
> Another perspective here would be, user can insert the module and
> Get JTAG connectivity, which also seems ok to me.

Yes both ways should be doable.
 
> Can you also confirm on having command line argument? I think
> We can only live with DT based approach, right?

Well I doubt that anybody wants to keep it permanently enabled
because of the power consumption and blocking of PM states, so
an additional cmdline might make sense.

It would be nice to have it most of the time built-in but disable
itself unless something debug is specified in the cmdline.

Maybe the JTAG driver can detect when the cable is connected?
Or maybe that would be only when there's clock coming over
JTAG?

Regards,

Tony
