From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 6 Jul 2010 14:48:29 +0300
Subject: [PATCH 05/15] omap: hsmmc: add virtual card detect support
In-Reply-To: <AANLkTim4E4LlFERmfYA1M0HLBOoRAsQuvdW6QBNu6pC0@mail.gmail.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-6-git-send-email-ohad@wizery.com>
	<alpine.LFD.2.00.1007052134460.6020@xanadu.home>
	<AANLkTim4E4LlFERmfYA1M0HLBOoRAsQuvdW6QBNu6pC0@mail.gmail.com>
Message-ID: <AANLkTinE5LygUWJsJSEE2miZF1GK58LTr8zErkuu_7yM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 6, 2010 at 1:22 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Note: the wl1271 device does support standard card detection, but
> AFAIK there's a limitation to use that with the specific omap
> controller the device is hardwired to. I will try to get more info
> about that, but probably Madhu can comment on that better.


Some correction and additional info:

The wl1271 device has an issue which makes the standard card detect
mechanism irrelevant: it is always up, even if the power enable gpio
input of the device is down (the power enable input does not supply
the power to the chip, it's just logical digital high/low input upon
which the device reacts).  That's why we must use software control for
emulating card detect with that device.

In addition, as far as I could find out, the card detect mechanism on
the ZOOM is implemented by mechanical means, and thus is not relevant
for hardwired embedded SDIO devices (I'm not even sure card detect is
supported for the 3rd mmc controller).
