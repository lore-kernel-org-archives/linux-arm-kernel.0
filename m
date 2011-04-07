From: lethal@linux-sh.org (Paul Mundt)
Date: Fri, 8 Apr 2011 01:56:54 +0900
Subject: [PATCH/RFC 4/6] ARM: move SH-mobile runtime PM to arm/common for
	sharing with other platforms
In-Reply-To: <1302134569-22825-5-git-send-email-khilman@ti.com>
References: <1302134569-22825-1-git-send-email-khilman@ti.com>
	<1302134569-22825-5-git-send-email-khilman@ti.com>
Message-ID: <20110407165654.GD8052@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2011 at 05:02:47PM -0700, Kevin Hilman wrote:
> There is really nothing SH-mobile specific about this runtime PM
> implementation.  Any platform wanting to implement runtime PM based on
> simple clock gating can use this implementation.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

This observation is wholly architecture agnostic, so it's not clear that
keeping it in arch/arm/common is any better. It seems that this would be
better suited for drivers/base/power/ with a generic Kconfig symbol.
