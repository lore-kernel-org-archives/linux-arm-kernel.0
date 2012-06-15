From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 15 Jun 2012 10:22:17 +0000
Subject: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <4FDA3464.4040704@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <fb739c3c5383806f78cee3666f7c74d61bed6427.1339419492.git.afzal@ti.com>
 <4FD64D6D.3020401@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997DD6@DBDE01.ent.ti.com>
 <4FD77EF1.8000600@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9987B2@DBDE01.ent.ti.com>
 <4FD8A906.8080202@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999582@DBDE01.ent.ti.com>
 <4FD9E5AF.6010201@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999CA6@DBDE01.ent.ti.com>
 <4FDA3464.4040704@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99A511@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Fri, Jun 15, 2012 at 00:28:44, Hunter, Jon wrote:
> On 06/14/2012 08:32 AM, Mohammed, Afzal wrote:
> > On Thu, Jun 14, 2012 at 18:52:55, Hunter, Jon wrote:

> >> Why? You currently have a global variable storing the clock handle. It
> >> can be quite common for drivers to know the clock frequencies of their
> >> functional clocks. How else can drivers calculate timings?
> > 
> > 
> > Please see Russell King's comments,
> > 
> > [1] http://permalink.gmane.org/gmane.linux.ports.ppc.embedded/27634
> > [2] http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg05365.html
> 
> Thanks. So I still think you need to get rid of the global variable for
> storing the gpmc fclk, that is really my point.
> 
> So if you look at commit [1] mentioned by Russell in the above thread,
> the appropriate thing to do would be to create a gpmc clock alias for
> all OMAP2+ devices and then you could simply call the following from the
> gpmc probe ...
> 
> 	gpmc_fck = clk_get(&pdev->dev, "fck");
> 
> You could then store somewhere in one of the gpmc structures.

Here clock is required even before driver is probed, i.e for platform to
calculate timings, that has to be passed through platform data.

I understand the necessity for clk rate information in driver, but seems
unless we have a generic way to scale timings for all the kinds of
peripheral, having it may not be of much help.

Regards
Afzal
