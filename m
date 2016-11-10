From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 10 Nov 2016 09:34:52 +0100
Subject: PM regression with LED changes in next-20161109
In-Reply-To: <20161109192301.GS26979@atomide.com>
References: <20161109192301.GS26979@atomide.com>
Message-ID: <621758ce-dd3f-41ad-d9b8-b8e34538700e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09-11-16 20:23, Tony Lindgren wrote:
> Hi,
>
> Looks like commit 883d32ce3385 ("leds: core: Add support for poll()ing
> the sysfs brightness attr for changes.") breaks runtime PM for me.
>
> On my omap dm3730 based test system, idle power consumption is over 70
> times higher now with this patch! It goes from about 6mW for the core
> system to over 440mW during idle meaning there's some busy timer now
> active.

Do you have any blinking LEDs or LED triggers defined on the system ?

> Reverting this patch fixes the issue. Any ideas?

All I can think of is something calling led_set_brightness quite often,
the patch in question makes led_set_brightness somewhat more expensive,
but it should not cause such a big difference unless something is
really calling led_set_brightness quite often maybe something is calling
it with the same value all the time ?

Regards,

Hans
