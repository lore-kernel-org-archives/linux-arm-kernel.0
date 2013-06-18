From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 18 Jun 2013 15:19:03 +0530
Subject: [PATCH v7 2/9] usb: phy: omap-usb2: use the new generic PHY
 framework
In-Reply-To: <20130618094058.GQ5461@arwen.pp.htv.fi>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-3-git-send-email-kishon@ti.com>
 <20130618094058.GQ5461@arwen.pp.htv.fi>
Message-ID: <51C02D0F.6010302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 18 June 2013 03:10 PM, Felipe Balbi wrote:
> Hi,
>
> On Thu, Jun 13, 2013 at 02:13:52PM +0530, Kishon Vijay Abraham I wrote:
>> @@ -159,6 +191,12 @@ static int omap_usb2_probe(struct platform_device *pdev)
>>   	otg->start_srp		= omap_usb_start_srp;
>>   	otg->phy		= &phy->phy;
>>
>> +	pm_runtime_enable(phy->dev);
>
> enabling pm_runtime here has the potential to cause a real big problem.
> How have you tested this patch ?

performed boot and enumeration testing. What issue do you expect here?

Thanks
Kishon
