From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 19 Mar 2013 07:59:20 +0100
Subject: [PATCH] ARM: kirkwood: Add support for NETGEAR ReadyNAS Duo v2
 using DT
In-Reply-To: <20130319060750.GD21478@lunn.ch> (Andrew Lunn's message of "Tue,
 19 Mar 2013 07:07:50 +0100")
References: <8738vt3h11.fsf@natisbad.org> <20130317205047.GU21478@lunn.ch>
 <87mwu0pamh.fsf@natisbad.org> <20130319060750.GD21478@lunn.ch>
Message-ID: <87zjxzvprr.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks guys,

Andrew Lunn <andrew@lunn.ch> writes:

>> [    7.599773] USB Power: Failed to request enable GPIO14: -517
>> [    7.605963] reg-fixed-voltage 1.regulator: Failed to register regulator: -517
>> [    7.613163] platform 1.regulator: Driver reg-fixed-voltage requests probe deferral
>
> Although this is quite noisy, it is actually not an error. What it is
> saying is that it failed to get the gpio and it will try again
> later. -517 is EDEFERE. It failed, because at this point, the GPIO
> driver has not yet loaded. Later in the boot the gpio driver
> loaded. It around the time you see:
>
> kirkwood-pinctrl f1010000.pinctrl: registered pinctrl driver
>
> At some point, the kernel will retry again to load all drivers which
> failed with EDEFER and the second time the regulator driver should
> load.

Stupid me: I first tried w/ "gpio = <&gpio0 14 0>;", plugged a key to
notice it was not seen, then looked at the logs to discover what seems
to be an error message. Then, I noticed I was addressing gpio0 (as Jason
also pointer) and thought this was the reason changed it for gpio1. At
that point, I should have tested w/ a USB key but instead looked at the
log to check if the message was still here.

Bottome line: it works! I'll resubmit a v2 later this day.

Thanks again.

Cheers,

a+
