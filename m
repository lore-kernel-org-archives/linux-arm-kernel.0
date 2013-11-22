From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 Nov 2013 18:33:56 +0000
Subject: [PATCH 2/8] ASoC: fsl-ssi: Move sysfs stats to debugfs
In-Reply-To: <20131122164204.GB5893@pengutronix.de>
References: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
 <1384938262-20554-3-git-send-email-mpa@pengutronix.de>
 <20131121142208.GU2674@sirena.org.uk>
 <20131122164204.GB5893@pengutronix.de>
Message-ID: <20131122183356.GQ14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 05:42:04PM +0100, Markus Pargmann wrote:
> On Thu, Nov 21, 2013 at 02:22:08PM +0000, Mark Brown wrote:
> > On Wed, Nov 20, 2013 at 10:04:16AM +0100, Markus Pargmann wrote:

> > > This patch moves the statistics to debugfs and disables interrupts
> > > completely if the kernel is build without DEBUG_FS enabled.

> > We can still see the error counts through /proc/interrupts even without
> > the debugfs file.

> The interrupts are visible without the debugfs file when enabled through
> SIER register. But it does not show the specific reason for the interrupts.

> I am not sure what you suggest. To remove the stats file completely and
> always disable interrupts?

No, I'm suggesting not disabling interrupts completely when debugfs is
disabled.  Since we can still see the interrupts happening even if
debugfs is not enabled we're still getting diagnostics.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131122/02cdf897/attachment.sig>
