From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 9 Apr 2014 17:54:38 +0530
Subject: [PATCH] phy: exynos5-usbdrd: Add facility to toggle vbus gpio
 on/off
In-Reply-To: <534538F6.2010009@samsung.com>
References: <1397044485-26483-1-git-send-email-gautam.vivek@samsung.com>
 <534538F6.2010009@samsung.com>
Message-ID: <CAFp+6iHf5Ndt3yNbdAaayXi08-A54Sk8LDTiASm4RTw09GuWvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,


On Wed, Apr 9, 2014 at 5:41 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> Hi Vivek,
>
> On 09/04/14 13:54, Vivek Gautam wrote:
>> Adding support to enable/disable VBUS hooked to a gpio
>> to enable vbus supply on the port.
>
> Does the GPIO control a fixed voltage regulator ? If so, shouldn't
> it be modelled by the regulator API instead ?

No, this GPIO controls a 'current limiting power distribution switch',
which gives the output vbus to usb controller.
Should i model this as a fixed regulator ?

>
>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> [...]
>> +     /* Get required GPIO for vbus */
>> +     phy_drd->gpio = of_get_named_gpio(dev->of_node,
>> +                                       "samsung,vbus-gpio", 0);
>> +     if (!gpio_is_valid(phy_drd->gpio))
>> +             dev_dbg(dev, "no usbdrd-phy vbus gpio defined\n");
>> +
>> +     if (devm_gpio_request(dev, phy_drd->gpio, "phydrd_vbus_gpio"))
>> +             dev_dbg(dev, "can't request usbdrd-phy vbus gpio %d\n",
>> +                     phy_drd->gpio);
>
> --
> Regards,
> Sylwester
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
