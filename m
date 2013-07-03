From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 3 Jul 2013 09:31:38 +0200
Subject: [GIT PULL 3/7] ARM SoC specific changes
In-Reply-To: <20130702231706.GF24642@n2100.arm.linux.org.uk>
References: <201307022055.50717.arnd@arndb.de>
 <201307022104.01826.arnd@arndb.de>
 <20130702231706.GF24642@n2100.arm.linux.org.uk>
Message-ID: <201307030931.39043.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 July 2013, Russell King - ARM Linux wrote:
> Please don't merge this yet.
> 
> Arnd has just done the worst possible thing - the arm-soc tree has taken
> bits of my tree, merged them into their own tree, had the same conflicts
> I've had, and then resolved them differently.
> 
> The result is that when these two trees now merge, they conflict on the
> conflict resolutions.  This is utter madness.

I assume you mean the confict in arch/arm/include/asm/glue-proc.h, right?

I'm sorry I did not realize that the conflict was between a commit
from your tree and from v3.10, otherwise I would have waited for your
pull request to come first.

I did the merge in my latest for-next branch, but not in the branches
that I sent off to Linus, instead I describe the conflict and Linus
picked one of the two possible resolutions. Unfortunately it was the
one I had, not yours, so he will get the conflict between the merges
again when he pulls your tree. I don't think there is any good way
to avoid that now, but since Linus now knows about the conflict it
at least won't be hard for him to figure out the solution, in this
case by using your version of the file.

	Arnd
