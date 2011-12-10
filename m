From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 10 Dec 2011 10:52:53 +0100
Subject: [PATCH] ARM: provide XIP_VIRT_ADDR for no-MMU builds
In-Reply-To: <20111210010221.GN14542@n2100.arm.linux.org.uk>
References: <1323467451-12128-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111210010221.GN14542@n2100.arm.linux.org.uk>
Message-ID: <20111210095253.GV4585@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 10, 2011 at 01:02:21AM +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 09, 2011 at 10:50:51PM +0100, Uwe Kleine-K?nig wrote:
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Lack of changelog.  Say why this change is required.
Something like:

	XIP_VIRT_ADDR is needed for XIP builds and currently only
	defined for builds with CONFIG_MMU.

	Also provide it for no-MMU builds to make it possible to build
	an XIP kernel for MMU-less machines. As these lack an MMU it has
	to be an identity mapping.

?

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
