From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 3 Jun 2012 17:12:18 +0000
Subject: Kernel 3.4 on Dreamplug: no serial console
In-Reply-To: <1475115.7BtuQWbDGm@gromit>
References: <loom.20120602T135715-548@post.gmane.org>
 <loom.20120603T172511-816@post.gmane.org> <1475115.7BtuQWbDGm@gromit>
Message-ID: <201206031712.18645.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 03 June 2012, Adam Baker wrote:
> As there are now two of us who have been tripped up by this does anyone think 
> the untested patch below is
> 
> a) worthwhile

yes

> b) likely to be acceptable

no

> c) likely to work

yes

> It feels wrong to be putting something arch specific in such general code but 
> setting it as a default is cleaner than trying to select it from 
> ARCH_KIRKWOOD_DT because default respects depends lines.

Just put it into the kirkwood_defconfig file, that is the cleanest approach by
far. We might still get a few people who run into this problem when updating,
but in the long run it will be ok.

I'd also accept a patch to make ARCH_KIRKWOOD_DT select OF_SERIAL if people
prefer that, but I think just changing the defconfig is better.

	Arnd
