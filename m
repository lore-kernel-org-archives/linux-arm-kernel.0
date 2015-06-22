From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Jun 2015 10:30:34 -0300
Subject: [PATCH] ARM: imx6: Fix "BUG: scheduling while atomic" if PCIe
 switch is attached
In-Reply-To: <1434616021.3061.2.camel@pengutronix.de>
References: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
 <1434616021.3061.2.camel@pengutronix.de>
Message-ID: <CAOMZO5BLQXKwVjykQVVmD1kHHm=M31RJPmgGa1Tznz8gpYwvyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 5:27 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

>> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
>> index fdb9536..c63691c 100644
>> --- a/drivers/pci/host/pci-imx6.c
>> +++ b/drivers/pci/host/pci-imx6.c
>> @@ -489,7 +489,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
>>                * Wait a little bit, then re-check if the link finished
>>                * the training.
>>                */
>> -             usleep_range(1000, 2000);
>> +             mdelay(20);
>
> While switching to mdelay might be the right thing to do here, you are
> also changing the timeout. This is a change in behavior and so not okay.

msleep(2) is not recommended according to Documentation/timers/timers-howto.txt.

What would be the proper fix then?

Regards,

Fabio Estevam
