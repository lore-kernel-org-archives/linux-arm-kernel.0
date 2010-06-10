From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jun 2010 00:05:52 +0100
Subject: [PATCH] sa1111: Prevent deadlock in resume path
In-Reply-To: <201006102349.12849.marek.vasut@gmail.com>
References: <1274901104-22133-1-git-send-email-marek.vasut@gmail.com>
	<20100526201824.GA16418@n2100.arm.linux.org.uk>
	<20100610135609.GC4514@ucw.cz>
	<201006102349.12849.marek.vasut@gmail.com>
Message-ID: <20100610230552.GE32362@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 10, 2010 at 11:49:12PM +0200, Marek Vasut wrote:
> Even though my problem was fixed (yeah, sorry Russell, I didn't know
> the patch tracker was updated to support git-send-email), I have a
> question though.
> 
> I believe that Kernel-version is unnecessary. Isn't this information already 
> encoded in the git-send-emailed patch?

It's there so that gnu patches can be accepted, and the additional
information does help when applying hard to apply patches, particularly
if either the patch has aged or was generated against an old kernel
version.

Not only that, but it was once critical when we had 2.4 and 2.5/2.6
kernel patches going via the patch system.

Last point to make - and it's in similar vain to the KernelVersion
tag - is that it would be useful if people would tag pure fixes which
should be applied to previous kernels with a "Cc: <stable@kernel.org>"
tag along-side the existing sign-offs.  That allows the stable
maintainers to automatically pick up on these patches when they're
merged into mainline.
