From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Oct 2010 20:22:45 +0100
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20101007192245.GC26435@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 07, 2010 at 12:44:22PM +0300, Felipe Contreras wrote:
> Many drivers are broken, and there's no alternative in sight. Such a big
> change should stay as a warning for now, and only later should it
> actually fail.
> 
> The drivers are not doing something correct, we get it, but for now it's
> better to allow them to work (they do 99% of the time anyway) rather
> than to force everyone to revert this patch in their internal trees
> until there's a solution. A slightly broken functionality is better than
> no functionality at all.
> 
> A warning lets people know that what they are doing is not right, and
> they should fix it.

So what are _you_ going to do to fix these drivers?  Continue reverting
this patch?  Or are you just going to ignore the issue entirely?

Unless people can come up with a plan to fix their drivers using ioremap
on system RAM thereby violating the architecture specification, I'm
_not_ going to apply this patch.
