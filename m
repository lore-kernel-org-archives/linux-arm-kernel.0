From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 01 Jun 2015 11:28:23 +0200
Subject: [PATCH v4 1/2] phy-sun4i-usb: Add full support for usb0 phy / OTG
In-Reply-To: <20150601092249.GF17267@lukather>
References: <1433088626-8858-1-git-send-email-hdegoede@redhat.com>
 <1433088626-8858-2-git-send-email-hdegoede@redhat.com>
 <20150601092249.GF17267@lukather>
Message-ID: <556C25B7.80708@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01-06-15 11:22, Maxime Ripard wrote:
> On Sun, May 31, 2015 at 06:10:25PM +0200, Hans de Goede wrote:
>> +	/* We either want both gpio pins or neither (when in host mode) */
>> +	if (!data->id_det_gpio != !data->vbus_det_gpio) {
>> +		dev_err(dev, "failed to get id or vbus detect pin\n");
>> +		return -ENODEV;
>> +	}
>
> The fact that the driver expects both to be set if one is should be in
> the binding documentation.

That would be behavior description, and I've always been told that the
binding should only document the hardware description, not the behavior.

Also this may change in the future as we add support for more boards,
e.g. the cubieboard seems to be unable to turn vbus off ever, so vbus-det
will always read as 1 / high, making it rather useless. This is something
which I still need to figure out how to deal with.

Regards,

Hans
