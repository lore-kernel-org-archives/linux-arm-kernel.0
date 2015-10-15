From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Oct 2015 16:32:46 +0100
Subject: [PATCH v2 1/3] ARM: catch pending imprecise abort on unmask
In-Reply-To: <1444905142-21500-2-git-send-email-l.stach@pengutronix.de>
References: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
 <1444905142-21500-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <20151015153246.GH32536@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 12:32:20PM +0200, Lucas Stach wrote:
> Install a non-faulting handler just before unmasking imprecise aborts
> and switch back to the regular one after unmasking is done.
> 
> This catches any pending imprecise abort that the firmware/bootloader
> may have left behind that would normally crash the kernel at that point.
> As there are apparently a lot of bootlaoders out there that do such a
> thing it makes sense to handle it in the common startup code.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Much better.  Please feel free to add it to the patch system, thanks.

I think, given that the original seems to be breaking platforms, this
patch needs to go into -rc kernels, right?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
