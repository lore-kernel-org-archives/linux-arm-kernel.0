From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 18 May 2016 18:57:46 +0100
Subject: [PATCH] usb: echi-hcd: Add register access check in shutdown
In-Reply-To: <Pine.LNX.4.44L0.1605181044460.1981-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1605181044460.1981-100000@iolanthe.rowland.org>
Message-ID: <573CAD1A.4090805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/05/16 15:56, Alan Stern wrote:
> This doesn't seem like the right place.  What you really should do is
> skip calling ehci_silence_controller() if the hardware isn't
> accessible.  That's where the hardware gets touched, not in
> ehci_shutdown().

Just tried this suggestion, this would not work as well, Its not just 
the hardware registers, which are of concern here, but also the rest of 
the things like ehci->hrtimer pointer which are allocated or initialized 
as part of ehci_setup().

Either the msm controller driver is not correct or we should have a way 
to stop calling ehci_shutdown() if there was no ehci_setup() done yet.

Any suggestions?


--srini
