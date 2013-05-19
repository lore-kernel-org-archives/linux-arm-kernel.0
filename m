From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 19 May 2013 20:45:15 +0200
Subject: [PATCH 2/2] ARM: mvebu: Add support for NOR flash device on
 Armada XP-DB board
In-Reply-To: <20130519181632.GG11137@titan.lakedaemon.net>
References: <1368788998-4672-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1368788998-4672-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130517165656.GE11137@titan.lakedaemon.net>
 <20130519091326.74a77b91@skate>
 <20130519181632.GG11137@titan.lakedaemon.net>
Message-ID: <20130519204515.3f746331@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Sun, 19 May 2013 14:16:32 -0400, Jason Cooper wrote:

> > Is mvebu/fixes the branch intended to be pushed to 3.10-rcX, or to
> > 3.11 ?
> > 
> > I'm asking because you've applied both 1/2 and 2/2 on the same
> > mvebu/fixes branch, while 1/2 is intended for 3.10-rcX (fixing
> > existing DT data), and 2/2 is intended for 3.11 (adding support for a
> > new device in the DT).
> 
> I've added it to /fixes because it implements the same fix the other
> patch did for the change in DT parsing.  I debated asking Ezequiel to
> split it into two patches, one for the ranges fix, the other for the new
> nodes.  In the end, since it isn't C code, I elected for simplicity.

The addition to the range property is *only* needed because the NOR DT
node is added. The two are needed together, so splitting them would
make absolutely no sense.

The reason why for the other board is was done in two patches is
because at the time Ezequiel sent the patch for the NOR, we were not
using this common ranges = <...> property in the DT. The additional
entry in the ranges = <...> property should have been added when the DT
reorganization was merged with the NOR patch from Ezequiel, but it
was not done. So Ezequiel sent a fixup patch to fix this.

There's no need to repeat the same story for the NOR flash of the
Armada XP DB.

Again, PATCH 1/2 is a fix for something that exists in 3.10-rc, while
PATCH 2/2 is enabling a new device, so presumably, it should go in 3.11.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
