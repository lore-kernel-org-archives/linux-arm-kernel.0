From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 5 May 2012 13:17:40 +0000
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <20120505080936.GP4141@pengutronix.de>
References: <201205031350.35476.arnd@arndb.de>
 <201205041624.17850.arnd@arndb.de> <20120505080936.GP4141@pengutronix.de>
Message-ID: <201205051317.40357.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 05 May 2012, Sascha Hauer wrote:
> They should not if they are not interested in these boards, but why
> shouldn't I be able to enable these 25 boards plus a few atmel or pxa
> boards?
> 
> When there are technical reasons to limit a multiplatform Kernel to DT
> only, then fine, lets do it that way. If there are no technical reasons
> and this limitation shall only be used to put some political pressure on
> platform board maintainers, then I am against it. Look around, people
> actually are porting their boards over to device tree, I don't think
> that such pressure is necessary.

It's definitely not a hard technical reason, just me trying to find
ways to simplify the problem space an any possible way. Basically all
code that can get built into the kernel has the ability to break other
stuff and causes bloat, see the recent discussion about putting
late_initcall into the machine_desc.

> Only my two cents, it's not that important to me since I want to port my
> (relevant) boards over to DT anyway, so I won't argue about this.

Ok, thanks for your input!

>From the statements made so far, I can see no clear policy that we can
apply to everyone. My take on this is that for any work I spend on
multiplatform kernel, I concentrate on the DT-based board files and
get them to work together first, but leave it up to the individual
subarch maintainers whether they want to add other board files into
the mix.

	Arnd
