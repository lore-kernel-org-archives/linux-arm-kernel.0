From: w@1wt.eu (Willy Tarreau)
Date: Fri, 22 Dec 2017 23:00:56 +0100
Subject: [PATCH v2 3/5] mtd: nand: replace pxa3xx_nand driver by its
 rework called marvell_nand
In-Reply-To: <20171222221032.30f83cb5@bbrezillon>
References: <20171219132942.27433-1-miquel.raynal@free-electrons.com>
 <20171219132942.27433-4-miquel.raynal@free-electrons.com>
 <87608ycwx5.fsf@belgarion.home>
 <20171222221032.30f83cb5@bbrezillon>
Message-ID: <20171222220056.GB14055@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 10:10:32PM +0100, Boris Brezillon wrote:
> On Fri, 22 Dec 2017 21:47:18 +0100
> Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> > What I would propose instead is :
> >  - keep both the new marvell nand driver and the old pxa3xx_nand driver
> >  - switch pxa_defconfig to compile them both
> >  - continue testing (with my help)
> > 
> > Once I see the marvell_nand is working properly, we can remove pca3xx_nand in a
> > second stage, keeping the pxa platform functional all along.
> > 
> > Would you agree to that path ?
> 
> Hm, I tried this approach already (with Marvell's crypto engine) and it
> doesn't quite solve the problem, just delay it a bit until someone
> decides to remove the old driver. In my experience, people only start
> testing the new driver when they're forced to do it (IOW, when the old
> driver is removed and defconfigs are patched to use the new one). So
> let's find a way to fix the remaining issues you have instead of
> delaying the inevitable.

That also reminds me of the old vs new PATA/IDE drivers a long time ago.
A number of us would stay on the old ones because we were satisfied,
never really making the effort to migrate until it we were really forced.

For the NAND, I think that if the old driver had to coexist with the new
one, at the very least the config option name must change so that it's
not selected by default by make oldconfig, and it's clearly written that
it is not maintained anymore, may be broken and that any one having a
good reason to use it must absolutely contact the maintainer to get the
other one fixed.

Just my two cents,
Willy
