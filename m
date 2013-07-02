From: olof@lixom.net (Olof Johansson)
Date: Mon, 1 Jul 2013 21:53:04 -0700
Subject: [GIT PULL] Initial OLPC XO-1.75/XO-4 support
In-Reply-To: <20130702031244.B2D74FAAD2@dev.laptop.org>
References: <20130702031244.B2D74FAAD2@dev.laptop.org>
Message-ID: <20130702045304.GA27829@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 11:12:44PM -0400, Daniel Drake wrote:
> Hi,
> 
> These patches add support for booting OLPC XO-1.75 (Marvell MMP2) and OLPC
> XO-4 (Marvell MMP3) which present device trees from OpenFirmware.
> 
> With the exception of the most recent patch, which has been acked (I think),
> the other patches were posted about 2 weeks ago and haven't received
> any comments from the MMP arch maintainers.
> 
> Please consider for the next available merge window (not sure if we're
> now too late for 3.11, no big deal if so).

Daniel,

Unfortunately too late for 3.11 indeed, so this is 3.12 material at this point.
Given that the merge window just opened, most maintainers will be too busy to
look at much new patches at this time as well.

Can I ask you to do a few things though?

1) Please post the drivers/clk patches to mturquette. THey don't look dependent
   on the rest of the patches, just general improvements and cleanups.
2) I really wish there was a generic catch-all compat for the boards, so we
   didn't have to modify mmp2-dt.c for every new board added -- it really
   defies the purpose of only changing the data you pass into the kernel. This
   is mostly something for Eric/Haojian to sort out though.
3) Please post the patches as a series instead of a pull request, given that
   they should probably take different paths up the tree (clk vs the platform,
   etc). You should at least get review/acked-by of the clk pieces from Mike
   Turquette.

Beyond that I didn't look all that closely at the patches yet.


-Olof
