From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Nov 2011 23:55:31 +0000
Subject: [PATCH] ARM: Add lsxhl machine type to mach-types
In-Reply-To: <201111130040.42616.michael@walle.cc>
References: <1320699251-26115-1-git-send-email-michael@walle.cc>
 <201111121702.15274.michael@walle.cc>
 <20111112230157.GB27746@n2100.arm.linux.org.uk>
 <201111130040.42616.michael@walle.cc>
Message-ID: <20111112235531.GE27746@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 13, 2011 at 12:40:42AM +0100, Michael Walle wrote:
> then, i guess, the problem is on the uboot side, at least if they want to 
> support both device tree based and old-fashioned setup code (eg. backported 
> device support.)

If uboot wants to carry the full list, rather than copying it from
the kernel source, they should be going straight to the main source
of the file (which is given inside the file itself.)

Otherwise, if they want to be purely dependent on the version shipped
with the kernel, which will have entries for platforms not merged into
the kernel source deleted from it once they're older than 12 months -
but which may be in u-boot, they can continue taking it out of the
kernel tree.  I think that's sub-optimal as they'll see regressions
from time to time when platforms have been merged into u-boot but not
the kernel.
