From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Nov 2016 10:55:37 -0700
Subject: PM regression with LED changes in next-20161109
In-Reply-To: <20161110162925.GA28832@amd>
References: <20161109192301.GS26979@atomide.com>
 <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
 <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <20161110162925.GA28832@amd>
Message-ID: <20161110175537.GF27724@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [161110 09:29]:
> Hi!
> 
> > >>>Looks like commit 883d32ce3385 ("leds: core: Add support for poll()ing
> > >>>the sysfs brightness attr for changes.") breaks runtime PM for me.
> > >>>
> > >>>On my omap dm3730 based test system, idle power consumption is over 70
> > >>>times higher now with this patch! It goes from about 6mW for the core
> > >>>system to over 440mW during idle meaning there's some busy timer now
> > >>>active.
> > >>>
> > >>>Reverting this patch fixes the issue. Any ideas?
> 
> Are you using any LED that toggles with high frequency? Like perhaps
> LED that is lit when CPU is active?

Yeah one of them seems to have cpu0 as the default trigger.

Tony
