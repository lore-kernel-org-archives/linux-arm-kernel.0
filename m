From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 14:59:24 +0000
Subject: [PATCH 10/18] ARM64: dts: meson-gxbb: Reorder nodes
In-Reply-To: <20170123165208.4ujwm6rjz2b3dom5@rob-hp-laptop>
References: <20170120222118.21476-1-afaerber@suse.de>
 <20170120222118.21476-11-afaerber@suse.de>
 <20170123165208.4ujwm6rjz2b3dom5@rob-hp-laptop>
Message-ID: <20170130145924.GX27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 10:52:08AM -0600, Rob Herring wrote:
> On Fri, Jan 20, 2017 at 11:21:10PM +0100, Andreas F?rber wrote:
> > Sort nodes referenced by label alphabetically.
> 
> Seems to be pointless churn.

Depends - if, as the author of a dts file, I order the nodes
alphabetically, and then someone comes along and adds a new node
non-alphabetically, meanwhile someone else also adds a node
elsewhere in the file which conflicts, git will silently merge the
changes without complaint.

Having an alphabetical sorting order means that (a) conflicting
changes are more likely to be highlighted, and (b) non-conflicting
changes are less likely to cause merge issues.

I've noticed exactly this with clearfog when merging my tree with
arm-soc.  I have a version of the DSA patch, meanwhile the mvebu
people merged the DSA patch.  Somehow, the order of nodes in my
file are alphabetical, the order in their file has the pinctrl and
mdio nodes swapped, which results in totally unnecessary merge
conflicts when I try merging the two trees.

It's more, unnecessary work.

So, I'm going to be submitting a patch to fix the mis-ordered nodes
in the clearfog dts file today to avoid having to resolve this each
time I rebuild my nightly build tree.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
