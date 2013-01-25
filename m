From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 25 Jan 2013 12:18:22 +0000
Subject: [PATCH v2 1/4] ARM: OMAP2+: dpll: round rate to closest value
In-Reply-To: <alpine.DEB.2.00.1301250816010.471@utopia.booyaka.com>
References: <cover.1358937533.git.afzal@ti.com>
 <871e6890897534b6c3669e252f23bef5ff1247b6.1358937533.git.afzal@ti.com>
 <alpine.DEB.2.00.1301250816010.471@utopia.booyaka.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA9388C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Fri, Jan 25, 2013 at 13:48:11, Paul Walmsley wrote:
> On Wed, 23 Jan 2013, Afzal Mohammed wrote:

> > Currently round rate function would return proper rate iff requested
> > rate exactly matches the PLL lockable rate. This causes set_rate to
> > fail if exact rate could not be set. Instead round rate may return
> > closest rate possible (less than the requested). And if any user is
> > badly in need of exact rate, then return value of round rate could
> > be used to decide whether to invoke set rate or not.
> > 
> > Modify round rate so that it return closest possible rate.
> 
> This doesn't look like the right approach to me.  For some PLLs, an exact 
> rate is desired.

If exact rate is required, there is a way to achieve it as mentioned
in the commit message, i.e. by first invoking round rate over reqd. rate
and if it doesn't match, bail out w/o invoking set_rate.

And it seems requirement of CCF w.r.t to round rate is to return closest
possible rate.

> We removed the rate tolerance code in commit 
> 241d3a8dca239610d3d991bf58d4fe38c2d86fd5, but that was probably premature.  
> We've encountered several situations now where we could really use it, 
> like MPU CPUFreq.  I'd suggest reverting 
> 241d3a8dca239610d3d991bf58d4fe38c2d86fd5 or using a similar approach.

As you prefer reverting the above commit, I will proceed so, hmm.. got
not so simple merge conflict, wish there was a command,
git revert logical ..

Regards
Afzal
