From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 6 Jul 2010 16:47:33 +0300
Subject: [PATCH 14/15] omap: zoom: add WLAN device
In-Reply-To: <4C33228D.8000908@nokia.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-15-git-send-email-ohad@wizery.com>
	<4C33228D.8000908@nokia.com>
Message-ID: <AANLkTilARXB6NVMOAC7lW1HSOzDnONveS0oK6MomvDy0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On Tue, Jul 6, 2010 at 3:33 PM, Roger Quadros <roger.quadros@nokia.com> wrote:
>> +static void omap_zoom_wlan_power(bool enable)
>> +{
>> + ? ? ? int val = enable ? 1 : 0;
>> +
>> + ? ? ? pr_info("%s: set power %d\n", __func__, val);
>> +
>> + ? ? ? gpio_set_value(OMAP_ZOOM_WLAN_PMENA_GPIO, val);
>> +}
>
> Can we consider that OMAP_ZOOM_WLAN_PMENA_GPIO is equivalent to vmmc supply
> or equivalent to supply voltage to the SDIO card?

Not really, this gpio does not supply power to the chip. It's only a
digital indication that instructs the chip to go into on or off mode.

Thanks,
Ohad.
