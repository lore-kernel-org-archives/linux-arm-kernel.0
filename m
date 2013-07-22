From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 22 Jul 2013 17:48:43 +0000 (UTC)
Subject: [PATCH 3/4] ARM: OMAP2+: Avoid idling memory controllers with
 no drivers
In-Reply-To: <1374487277-26099-4-git-send-email-rnayak@ti.com>
References: <1374487277-26099-1-git-send-email-rnayak@ti.com>
 <1374487277-26099-4-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.02.1307221746430.10891@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, 22 Jul 2013, Rajendra Nayak wrote:

> Memory controllers in OMAP (like GPMC and EMIF) have the hwmods marked with
> HWMOD_INIT_NO_IDLE and are left in enabled state post initial setup.
> 
> Even if they have drivers missing, avoid idling them as part of
> omap_device_late_idle()

Since this patch is intended for the -rc series, it's best if you explain 
here what effects this patch will fix.  i.e., does this fix a crash, a 
warning, etc?  Also maybe update your series description message?


- Paul
