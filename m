From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 30 Mar 2012 19:24:19 -0400
Subject: Support for Iomega iConnect
In-Reply-To: <201203302330.49834.linux@baker-net.org.uk>
References: <201203302330.49834.linux@baker-net.org.uk>
Message-ID: <20120330232419.GF7274@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 11:30:49PM +0100, Adam Baker wrote:
> Hi,

Hi Adam,

> Is anyone aware of any technical reason why support for the Iomega iConnect is 
> not included in the mainline kernel (e.g. there are significant changes 
> happening in the area of the Kirkwood CPUs that mean now isn't a good time to 
> include it).

No one ushered it in.  Patches are always welcome.

> There are several versions floating around the internet but as far 
> as I can see the only mention of the iConnect on this list is Russell saying 
> he will remove it from mach types soon as there is no mainline support for it.

mach-type is no longer needed, once conversion to devicetree is done.
Converting you patches to devicetree should be pretty easy.  See my
recommendation, below.

> Based upon work that Iomega posted to the open source code area on their web 
> site and code that was submitted to OpenWRT with a sign off line from Wojciech 
> Dubowik, I have patched support into the 3.2.11 kernel. If there is no 
> objection in principle to inclusion then I will rebase the patch and submit 
> it.

Please base off of v3.3 and merge in the following branch:

git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt_for_3.4_v3

This has been merged into Linus' tree, but it's after v3.3.

You can also look at the history in this branch to see how support for
dreamplug (also kirkwood SoC) was added.  Converting drivers to
devicetree is still a work in progress, so, just match what dreamplug is
doing.

Post the resulting patches to the ml, and I'll queue it up with the others
(after sufficient review, of course).

> Is Linus' git repository still the preferred baseline for linux-arm patches?

Yes, always base off of a tag as I mentioned above.

Just shout if you have any questions.

hth,

Jason.
