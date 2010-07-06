From: roger.quadros@nokia.com (Roger Quadros)
Date: Tue, 06 Jul 2010 15:39:06 +0300
Subject: [PATCH 05/15] omap: hsmmc: add virtual card detect support
In-Reply-To: <AANLkTinE5LygUWJsJSEE2miZF1GK58LTr8zErkuu_7yM@mail.gmail.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-6-git-send-email-ohad@wizery.com>
	<alpine.LFD.2.00.1007052134460.6020@xanadu.home>
	<AANLkTim4E4LlFERmfYA1M0HLBOoRAsQuvdW6QBNu6pC0@mail.gmail.com>
	<AANLkTinE5LygUWJsJSEE2miZF1GK58LTr8zErkuu_7yM@mail.gmail.com>
Message-ID: <4C3323EA.902@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/06/2010 02:48 PM, ext Ohad Ben-Cohen wrote:
> On Tue, Jul 6, 2010 at 1:22 PM, Ohad Ben-Cohen<ohad@wizery.com>  wrote:
>> Note: the wl1271 device does support standard card detection, but
>> AFAIK there's a limitation to use that with the specific omap
>> controller the device is hardwired to. I will try to get more info
>> about that, but probably Madhu can comment on that better.
>
>
> Some correction and additional info:
>
> The wl1271 device has an issue which makes the standard card detect
> mechanism irrelevant: it is always up, even if the power enable gpio
> input of the device is down (the power enable input does not supply
> the power to the chip, it's just logical digital high/low input upon
> which the device reacts).  That's why we must use software control for
> emulating card detect with that device.

Just to clarify, is the wl1271 device always powered on the board?

And this GPIO power enable (OMAP_ZOOM_WLAN_PMENA_GPIO) is used to gate this 
supply internally?

and what do these do ?

set_bit(WL1271_FLAG_GPIO_POWER, &wl->flags);

clear_bit(WL1271_FLAG_GPIO_POWER, &wl->flags);

regards,
-roger
