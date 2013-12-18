From: ynvich@gmail.com (Sergei Ianovich)
Date: Thu, 19 Dec 2013 01:20:46 +0400
Subject: [PATCH v2 00/16] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <201312182210.30544.arnd@arndb.de>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <201312182150.39037.arnd@arndb.de>
 <1387400193.31516.10.camel@host5.omatika.ru>
 <201312182210.30544.arnd@arndb.de>
Message-ID: <1387401646.31516.14.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-12-18 at 22:10 +0100, Arnd Bergmann wrote:
> On Wednesday 18 December 2013, Sergei Ianovich wrote:
> > Could we postpone this until someone needs this functionality?
> 
> We have to be sure that any device tree files you write now can remain
> compatible with future kernels if we add it later. My reasoning at first
> was that this wouldn't work if we had to change the "compatible" string
> for the bus node, but after re-thinking it now I believe that it's fine.

Great.

> You would still be able to boot a kernel with an old dts file on a new
> kernel if it just contains a "simple-bus" node here, as long as it doesn't
> need any boot-time setup at the bus controller. We can change the dts
> file later if we need to add this functionality, which would break booting
> old kernels with the new dts files, which isn't much of a problem in
> general.

It should actually only break old kernels which require new
functionally. Otherwise, dts can have

compatible = "marvell,pxa-extbus", "simple-bus";

and an older kernel will be happy with "simple-bus". Please correct me
if I'm wrong.
