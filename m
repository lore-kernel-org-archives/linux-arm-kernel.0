From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 17 Nov 2014 19:16:36 +0300
Subject: [PATCH v7 1/2] usb: host: xhci-plat: Get PHYs for xhci's hcds
In-Reply-To: <CAFp+6iG37uE1uB5Z8B-hM3nKyBeR6Vxb-YKegd7MrRB3wuA9xw@mail.gmail.com>
References: <1414761989-21088-1-git-send-email-gautam.vivek@samsung.com>	<1414761989-21088-2-git-send-email-gautam.vivek@samsung.com>	<545393CE.8070102@cogentembedded.com>
 <CAFp+6iG37uE1uB5Z8B-hM3nKyBeR6Vxb-YKegd7MrRB3wuA9xw@mail.gmail.com>
Message-ID: <546A1F64.7000209@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/17/2014 9:36 AM, Vivek Gautam wrote:

>>> The host controller by itself may sometimes need to handle PHY
>>> and re-initialize it to re-configure some of the PHY parameters
>>> to get full support out of the PHY controller.
>>> Therefore, facilitate getting the two possible PHYs, viz.
>>> USB 2.0 type (UTMI+) and USB 3.0 type (PIPE3), and initialize them.

>>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>>> ---
>>>    drivers/usb/host/xhci-plat.c |   74
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 74 insertions(+)

>>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>>> index 3d78b0c..5207d5b 100644
>>> --- a/drivers/usb/host/xhci-plat.c
>>> +++ b/drivers/usb/host/xhci-plat.c
[...]
>>> @@ -204,6 +271,8 @@ static int xhci_plat_suspend(struct device *dev)
>>>          struct usb_hcd  *hcd = dev_get_drvdata(dev);
>>>          struct xhci_hcd *xhci = hcd_to_xhci(hcd);
>>>
>>> +       phy_exit(hcd->phy);

>>     Hm, in the suspend() method?

> phy_exit() should eventually be suspending the PHY and put it to
> low power state.

    I thought it's a role that the power_off() mothod should play, considering 
that the power_on() method gets called after the init() method....

> phy_init() in resume() will then take up the task of activating the
> PHY again.

> phy_power_on() and phy_power_off() are called at xhci_probe() and remove() time.

    Of course.

> Does this makes sense ?

    Not much, really.

WBR, Sergei
