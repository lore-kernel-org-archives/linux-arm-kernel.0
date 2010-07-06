From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 6 Jul 2010 16:44:48 +0300
Subject: [PATCH 05/15] omap: hsmmc: add virtual card detect support
In-Reply-To: <4C3323EA.902@nokia.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-6-git-send-email-ohad@wizery.com>
	<alpine.LFD.2.00.1007052134460.6020@xanadu.home>
	<AANLkTim4E4LlFERmfYA1M0HLBOoRAsQuvdW6QBNu6pC0@mail.gmail.com>
	<AANLkTinE5LygUWJsJSEE2miZF1GK58LTr8zErkuu_7yM@mail.gmail.com>
	<4C3323EA.902@nokia.com>
Message-ID: <AANLkTikyeaVRxLDVjGmCOtcw9vZtHspKDK22Xojk7n8x@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 6, 2010 at 3:39 PM, Roger Quadros <roger.quadros@nokia.com> wrote:
> Just to clarify, is the wl1271 device always powered on the board?

Yes.

> And this GPIO power enable (OMAP_ZOOM_WLAN_PMENA_GPIO) is used to gate this
> supply internally?

Yes. It's a digital input that the chip does not draw current from
(well, only a very minimal one).

> and what do these do ?
>
> set_bit(WL1271_FLAG_GPIO_POWER, &wl->flags);
>
> clear_bit(WL1271_FLAG_GPIO_POWER, &wl->flags);

This is an internal driver bit that maintains the power state of the chip.
AFAICT, it does not "do" anything. The only place I can see it is
being used is in a debugfs entry.
