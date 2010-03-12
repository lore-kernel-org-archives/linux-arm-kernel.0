From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Fri, 12 Mar 2010 10:30:12 +0200
Subject: [PATCH 1/3] usb: Fix compile error for omaps for musb_hdrc
In-Reply-To: <20100311180322.20537.3614.stgit@baageli.muru.com>
References: <20100311180023.20537.27516.stgit@baageli.muru.com>
	<20100311180322.20537.3614.stgit@baageli.muru.com>
Message-ID: <20100312083012.GZ20878@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 11, 2010 at 07:03:22PM +0100, ext Tony Lindgren wrote:
>CONFIG_ARCH_OMAP34XX is now CONFIG_ARCH_OMAP3.
>
>But since drivers/usb/musb/omap2430.c use CONFIG_PM for these
>registers and functions, do the same for the header.
>
>Otherwise we get the following for most omap3 defconfigs:
>
>drivers/usb/musb/omap2430.c:261: error: expected identifier or '(' before 'do'
>drivers/usb/musb/omap2430.c:261: error: expected identifier or '(' before 'while'
>drivers/usb/musb/omap2430.c:268: error: expected identifier or '(' before 'do'
>drivers/usb/musb/omap2430.c:268: error: expected identifier or '(' before 'while'
>
>Signed-off-by: Tony Lindgren <tony@atomide.com>

I sent a version for that yesterday. Sorry :-(

-- 
balbi
