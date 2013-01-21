From: rogerq@ti.com (Roger Quadros)
Date: Mon, 21 Jan 2013 16:24:16 +0200
Subject: [RFC PATCH 6/6] USB: MUSB: OMAP: get PHY by phandle for dt boot
In-Reply-To: <50FD4593.5020007@ti.com>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <1358348462-27693-7-git-send-email-kishon@ti.com> <50FD4034.5040402@ti.com>
 <50FD4593.5020007@ti.com>
Message-ID: <50FD4F90.7080101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2013 03:41 PM, kishon wrote:
> Hi,
> 
> On Monday 21 January 2013 06:48 PM, Roger Quadros wrote:
>> On 01/16/2013 05:01 PM, Kishon Vijay Abraham I wrote:
>>> The OMAP glue has been modified to get PHY by phandle for dt boot.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>   drivers/usb/musb/omap2430.c |    7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>>> index 3628a50..08709cf 100644
>>> --- a/drivers/usb/musb/omap2430.c
>>> +++ b/drivers/usb/musb/omap2430.c
>>> @@ -346,7 +346,12 @@ static int omap2430_musb_init(struct musb *musb)
>>>        * up through ULPI.  TWL4030-family PMICs include one,
>>>        * which needs a driver, drivers aren't always needed.
>>>        */
>>> -    musb->xceiv = devm_usb_get_phy(dev, 0);
>>> +    if (dev->parent->of_node)
>>> +        musb->xceiv = devm_usb_get_phy_by_phandle(dev->parent,
>>> +            "usb_phy", 0);
>>
>> Why dev->parent and not just dev?
> 
> Right now MUSB core is not converted to dt and hence we don't have
> separate dt node for MUSB core.
> So the PHY information is added to the glue dt data.
> 

OK. Got it :).

--
cheers,
-roger
