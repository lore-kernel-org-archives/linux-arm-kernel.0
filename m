From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 May 2013 00:13:47 +0100
Subject: [PATCH -v7 0/11] Shutdown from reboot_cpuid without stopping
 other cpus.
In-Reply-To: <1367428011-17123-1-git-send-email-holt@sgi.com>
References: <1367428011-17123-1-git-send-email-holt@sgi.com>
Message-ID: <20130501231347.GT14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 12:06:40PM -0500, Robin Holt wrote:
> Andrew, Please do _NOT_ take this patch series yet.  I am sending this
> to you because you had comments on my -v6 submission.

Another reason for not applying this is that I believe it wilfully breaks
a bunch of ARM platforms - such as removing the 'g' reboot mode (for gpio
based reboot on PXA), and removing the 's' reboot mode off a bunch of ARM
platforms which have no way to do a hard reboot.

What scares me is that this is revision 7 of this patch set and this is
the first it's been noticed on ARM... Maybe this patch set didn't touch
ARM previously?
