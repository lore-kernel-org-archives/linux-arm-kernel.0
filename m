From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 21 May 2012 12:35:06 +0300
Subject: [PATCHv2 14/19] ARM: OMAP4: wakeupgen: enable clocks for
 save_secure_all
In-Reply-To: <alpine.DEB.2.00.1205161809230.2921@utopia.booyaka.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-15-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1205161809230.2921@utopia.booyaka.com>
Message-ID: <1337592906.28274.16.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-05-16 at 18:17 -0600, Paul Walmsley wrote:
> Hi Tero
> 
> On Mon, 14 May 2012, Tero Kristo wrote:
> 
> > save_secure_all needs l3_main_3_ick and l4_secure_clkdm enabled,
> > otherwise the secure ROM code will crash.
> 
> Do we know why the l3_main_3 interconnect has to be enabled?  Is this 
> needed to access some L3 or instrumentation registers?

Not sure, ROM code is doing something here which requires it, and the
ROM code definitely crashes without this. Your guess sounds plausible.

-Tero
