From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Apr 2012 15:39:17 +0100
Subject: [PATCH] staging: tidspbridge: fix build errors for
 OMAP2_L4_IO_ADDRESS
In-Reply-To: <1335191654-1217-1-git-send-email-felipe.contreras@gmail.com>
References: <1335191654-1217-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20120423143917.GD24299@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 05:34:14PM +0300, Felipe Contreras wrote:
> drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_start':
> drivers/staging/tidspbridge/core/tiomap3430.c:425: error: implicit declaration of function 'OMAP2_L4_IO_ADDRESS'
> drivers/staging/tidspbridge/core/wdt.c: In function 'dsp_wdt_init':
> drivers/staging/tidspbridge/core/wdt.c:56: error: implicit declaration of function 'OMAP2_L4_IO_ADDRESS'
> 
> The proper fix will come later.

Hmm.  Given that this is staging stuff, which hasn't been making much
progress out of staging, I'd suggest not doing the quick fix on it, but
spending the time to implement the proper fix now and move the code
closer to the point where it can move out of staging.  You might get
a gold star from Greg for moving this forward...
