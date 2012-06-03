From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 3 Jun 2012 14:40:49 -0400
Subject: Kernel 3.4 on Dreamplug: no serial console
In-Reply-To: <201206031712.18645.arnd@arndb.de>
References: <loom.20120602T135715-548@post.gmane.org>
 <loom.20120603T172511-816@post.gmane.org>
 <1475115.7BtuQWbDGm@gromit> <201206031712.18645.arnd@arndb.de>
Message-ID: <20120603184049.GF14756@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 03, 2012 at 05:12:18PM +0000, Arnd Bergmann wrote:
> I'd also accept a patch to make ARCH_KIRKWOOD_DT select OF_SERIAL if people
> prefer that, but I think just changing the defconfig is better.

I'd prefer the defconfig as there are situations where users/oems deploy
a kernel without support for serial console.  In order to do that with
your patch, or similar approaches, they would have to change the code.
With defconfig, they don't.

FYI: there is a running problem with kirkwood_defconfig that I haven't
had time to look into.  I've been doing 'make oldconfig' and thus never
encountered the problem.

The problem involves CONFIG_ARM_PATCH_PHYS_VIRT and causes the system
not to boot.  I'm not sure if this is dreamplug specific, kirkwood, or
all orion.  I've only heard reports regarding dreamplug, but that
doesn't mean it's limited to that board.

I'd like to have the defconfig working by the time the DT conversion is
complete, but I'm currently giving DT conversion higher priority.  So,
if anyone wants to take a crack at solving it, please do.  Otherwise, I
plan on taking a look at it after the driver bindings are done.

thx,

Jason.
