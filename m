From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Dec 2013 22:10:30 +0100
Subject: [PATCH v2 00/16] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <1387400193.31516.10.camel@host5.omatika.ru>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <201312182150.39037.arnd@arndb.de>
 <1387400193.31516.10.camel@host5.omatika.ru>
Message-ID: <201312182210.30544.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 December 2013, Sergei Ianovich wrote:
> > Hmm, this is a bit tricky then. I think it would be best to not
> > use "simple-bus" then, to allow migrating the other platforms later,
> > but that will be a little more work. Maybe you can register a trivial
> > driver in the platform code that only calls of_platform_populate on
> > the device for now?
> 
> Could we postpone this until someone needs this functionality?

We have to be sure that any device tree files you write now can remain
compatible with future kernels if we add it later. My reasoning at first
was that this wouldn't work if we had to change the "compatible" string
for the bus node, but after re-thinking it now I believe that it's fine.

You would still be able to boot a kernel with an old dts file on a new
kernel if it just contains a "simple-bus" node here, as long as it doesn't
need any boot-time setup at the bus controller. We can change the dts
file later if we need to add this functionality, which would break booting
old kernels with the new dts files, which isn't much of a problem in
general.

	Arnd
