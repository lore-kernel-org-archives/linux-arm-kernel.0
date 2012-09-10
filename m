From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 10 Sep 2012 13:01:45 -0400 (EDT)
Subject: [PATCH] ARM: Dove: allow PCI to be disabled
In-Reply-To: <20120910082941.GO13739@n2100.arm.linux.org.uk>
References: <E1TAnGn-00086i-Lb@rmk-PC.arm.linux.org.uk>
 <20120909204705.GD3451@lunn.ch>
 <20120909205521.GI13739@n2100.arm.linux.org.uk>
 <20120909210126.GM4575@titan.lakedaemon.net>
 <20120910004511.GN13739@n2100.arm.linux.org.uk>
 <20120910014422.GQ4575@titan.lakedaemon.net>
 <20120910082941.GO13739@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1209101246580.28681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Sep 2012, Russell King - ARM Linux wrote:

> On Sun, Sep 09, 2012 at 09:44:22PM -0400, Jason Cooper wrote:
> > iiuc, the regression you are refering to would occur iff this patch
> > (without the select) makes it into mainline _before_ Andrew's patch in
> > Greg's tree.  As I haven't pulled this patch yet, I can add a dependency
> > in the tag message listing the patch in gregkh's usb tree.
> 
> For the regression to occur, you need to land on a commit in the tree
> where this patch (without the select) is in the history but not the
> patch in Greg's tree.
> 
> The commit history remains a series of independent branches even after
> trees are merged into Linus' tree - there is _no_ linearisation of the
> history in git.

@Jason:

The dependency tracking done in the arm-soc tree performed by Arnd and 
Olof is merely a way for you to _base_ your branch on top of other 
people's branch before they pull it from you.  For example, you may 
decide to build your branch on top of Greg's to get some prerequisite 
commits for your work. In that case the goal for the arm-soc maintainers 
is to avoid the situation where a pull of the arm-soc tree into mainline 
would also pull greg's stuff without his asking for it.


Nicolas
