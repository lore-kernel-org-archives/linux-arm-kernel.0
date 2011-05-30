From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 May 2011 22:54:04 +0100
Subject: [PATCH] ARM: EXYNOS4: Fix secondary CPU boot after wake-up
In-Reply-To: <4DE36589.4080709@ti.com>
References: <1306746781-21511-1-git-send-email-inderpal.s@samsung.com>
	<4DE36589.4080709@ti.com>
Message-ID: <20110530215404.GB21382@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 03:08:17PM +0530, Santosh Shilimkar wrote:
> When do you plan to fix the SGI usage as discussed
> in above thread. I thought SGI1 usage was ok for OMAP,
> realview/versatile and MSM.

I'd like the use of the arbitary SGI1 to fade away, to be replaced with
something a little saner (eg, SGI0 being the first SGI).  That just
means you'll end up with a warning about SGI0 instead.  Let's just
ignore them for the time being (but please change to SGI0 anyway.)
