From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Thu, 10 Apr 2014 16:37:04 +0530
Subject: [PATCH] phy: exynos5-usbdrd: Add facility to toggle vbus gpio
 on/off
In-Reply-To: <53453F2E.40606@samsung.com>
References: <1397044485-26483-1-git-send-email-gautam.vivek@samsung.com>
 <534538F6.2010009@samsung.com>
 <CAFp+6iHf5Ndt3yNbdAaayXi08-A54Sk8LDTiASm4RTw09GuWvg@mail.gmail.com>
 <53453F2E.40606@samsung.com>
Message-ID: <CAFp+6iEktKhksj8-SaDr3Ep7iFf+cyp4-xNmw9DrmmiV5J6wyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Wed, Apr 9, 2014 at 6:08 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi,
>
>
> On 09.04.2014 14:24, Vivek Gautam wrote:
>>
>> Hi Sylwester,
>>
>>
>> On Wed, Apr 9, 2014 at 5:41 PM, Sylwester Nawrocki
>> <s.nawrocki@samsung.com> wrote:
>>>
>>> Hi Vivek,
>>>
>>> On 09/04/14 13:54, Vivek Gautam wrote:
>>>>
>>>> Adding support to enable/disable VBUS hooked to a gpio
>>>> to enable vbus supply on the port.
>>>
>>>
>>> Does the GPIO control a fixed voltage regulator ? If so, shouldn't
>>> it be modelled by the regulator API instead ?
>>
>>
>> No, this GPIO controls a 'current limiting power distribution switch',
>> which gives the output vbus to usb controller.
>> Should i model this as a fixed regulator ?
>
>
> If I understand this correctly, this is just a switch that lets you control
> whether vbus is provided to the USB connector or not. If so, this doesn't
> look like an Exynos-specific thing at all and should rather be modeled on
> higher level.

You are right. The Vbus to the USB connector is given through this a
switch which current limiting capabilities.
This switch just provides the 5V at its input to its output based on
the state of Enable pin
(which is the GPIO we are talking in this patch).

So can you please suggest on how this should be handled ?

>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
