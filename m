From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 05 Jul 2010 21:45:12 -0400 (EDT)
Subject: [PATCH 05/15] omap: hsmmc: add virtual card detect support
In-Reply-To: <1278376666-3509-6-git-send-email-ohad@wizery.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-6-git-send-email-ohad@wizery.com>
Message-ID: <alpine.LFD.2.00.1007052134460.6020@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Jul 2010, Ohad Ben-Cohen wrote:

> From: Ohad Ben-Cohen <ohadb@ti.com>
> 
> Add support for software emulation of card detect
> events.
> 
> This is required for specific controllers
> that are hard wired with embedded SDIO devices
> (such as TI's wl1271 WLAN device).

Why?

Many instances of hardwired SDIO based WLAN devices do exist already, 
and they don't need extra card detect events to be generated.  The core 
MMC code already triggers a probe for cards whenever a new host 
controller is registered.

> Board-specific configuration is required to
> enable this software card detect control.

Could you elaborate please?


Nicolas
