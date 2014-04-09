From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 09 Apr 2014 15:08:56 +0200
Subject: [PATCH] phy: exynos5-usbdrd: Add facility to toggle vbus gpio
 on/off
In-Reply-To: <CAFp+6iHf5Ndt3yNbdAaayXi08-A54Sk8LDTiASm4RTw09GuWvg@mail.gmail.com>
References: <1397044485-26483-1-git-send-email-gautam.vivek@samsung.com>
 <534538F6.2010009@samsung.com>
 <CAFp+6iHf5Ndt3yNbdAaayXi08-A54Sk8LDTiASm4RTw09GuWvg@mail.gmail.com>
Message-ID: <53454668.8090300@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/14 14:24, Vivek Gautam wrote:
> On Wed, Apr 9, 2014 at 5:41 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> > On 09/04/14 13:54, Vivek Gautam wrote:
>>> >> Adding support to enable/disable VBUS hooked to a gpio
>>> >> to enable vbus supply on the port.
>> >
>> > Does the GPIO control a fixed voltage regulator ? If so, shouldn't
>> > it be modelled by the regulator API instead ?
>
> No, this GPIO controls a 'current limiting power distribution switch',
> which gives the output vbus to usb controller.
> Should i model this as a fixed regulator ?

OK, it's just a power switch then. I suspect using the regulator API
would be more universal, as such a GPIO is somewhat a board design
detail. I'm not going to object to your patch, just might be better
to use the gpiod API instead.

-- 
Regards,
Sylwester
