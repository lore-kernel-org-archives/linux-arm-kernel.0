From: roger.quadros@nokia.com (Roger Quadros)
Date: Tue, 06 Jul 2010 11:53:45 +0300
Subject: [PATCH 11/15] wireless: wl1271: introduce platform device support
In-Reply-To: <1278376666-3509-12-git-send-email-ohad@wizery.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-12-git-send-email-ohad@wizery.com>
Message-ID: <4C32EF19.1000604@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/06/2010 03:37 AM, ext Ohad Ben-Cohen wrote:
> From: Ohad Ben-Cohen<ohadb@ti.com>
>
> Introduce a platform device support which is decoupled
> from the life cycle of the sdio function.
>
> The platform device objective is to deliver board-specific
> values (like irq, ref_clock, and software card-detect
> emulation control).
>
> The driver can then dynamically create (or destroy)
> the sdio function whenever the wlan interface is
> brought up (or down), as part of the power() operation.

Is this the right approach? Why should you emulate a card disconnect event when 
the wlan interface is brought down?

Physically the card is never disconnected. So I don't see why we should fake it.
Could you please explain why you need to do this?

br,
-roger
