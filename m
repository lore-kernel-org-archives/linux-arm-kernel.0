From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 13 Jan 2015 11:40:58 +0530
Subject: [PATCH v2 2/3] usb: phy: add lubbock phy driver
In-Reply-To: <20150112215159.GM2858@saruman>
References: <1417298525-5587-1-git-send-email-dbaryshkov@gmail.com>
 <1417298525-5587-3-git-send-email-dbaryshkov@gmail.com>
 <20150108165834.GH31926@saruman>
 <CALT56yOaX0EQbbFSXiFK=uqSpCwv4pQsU4QFMSmSoTstq2d7zw@mail.gmail.com>
 <20150112215159.GM2858@saruman>
Message-ID: <54B4B6F2.9040404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 13 January 2015 03:21 AM, Felipe Balbi wrote:
> On Sun, Jan 11, 2015 at 10:44:59PM +0400, Dmitry Eremin-Solenikov wrote:
>> Hello,
>>
>> 2015-01-08 19:58 GMT+03:00 Felipe Balbi <balbi@ti.com>:
>>> On Sun, Nov 30, 2014 at 01:02:04AM +0300, Dmitry Eremin-Solenikov wrote:
>>>> Extract lubbock-specific code from pxa25x_udc driver. As a bonus, phy
>>>> driver determines connector/VBUS status by reading CPLD register. Also
>>>> it uses a work to call into udc stack, instead of pinging vbus session
>>>> right from irq handler.
>>>>
>>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>>> ---
>>>>  drivers/usb/phy/Kconfig       |  10 ++
>>>>  drivers/usb/phy/Makefile      |   1 +
>>>
>>> new phy drivers under drivers/phy only, sorry.
>>
>> Hmm. How do drivers/phy drivers coordinate with usb gadget subsystem?
>> I see none of them calling usb_gadget_vbus_connect/disconnect().
> 
> I'll leave that to Kishon, since he wrote drivers/phy. Kishon, any
> hints?

Extcon framework can be used to detect the connector status. So the PHY driver
should register with the extcon framework if it has the capability to determine
the connector status and the gadget driver should register with the extcon
framework if it has to receive the connector status.

I'm not sure if we should be adding these extcon APIs inside the PHY framework
itself as all PHYs might not have the capability to detect the connector status.

Thanks
Kishon
