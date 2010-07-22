From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 23 Jul 2010 00:56:30 +0200 (CEST)
Subject: [PATCH v2 00/20] native support for wl1271 on ZOOM
In-Reply-To: <1279733634-21974-1-git-send-email-ohad@wizery.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
Message-ID: <alpine.LFD.2.00.1007230052320.12562@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Jul 2010, Ohad Ben-Cohen wrote:

> This patch series adds native support for wl1271 on ZOOM.
> 
> Changes since v1:
> 
> - introduce a fixed regulator device to control the power of wl1271
> - allow to propagate private board-specific data to SDIO function drivers
> - allow SDIO function driver to control the card's power via new API
> - make it possible to keep the card's power down (without depending
>   on an explicit SDIO function driver power-down request)
> 
> Thanks to these changes, we no longer need a separate platform
> device (carrying e.g. the external irq information of the device),
> and no longer need to emulate virtual card detect events.
> 
> The two "board muxing" pathces were already taken by Tony, and
> are resent here just to make it easier for people to use/test these pathces.
> 
> The changes to the MMC core really needs careful review; there still
> might be some pitfalls that haven't been covered. E.g., one thing
> we plan to look at next is their bahvior together with SDIO Suspend/Resume.
> 
> Special thanks to Roger Quadros and Nicolas Pitre for their extensive
> review and helpful suggestions.

FYI, I do intend to review those patches, but I'll be flying home in a 
couple hours, and once there I'll be gone on vacation for 2 weeks.  So 
this review won't happen right away.


Nicolas
