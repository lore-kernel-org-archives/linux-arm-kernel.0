From: B31939@freescale.com (Lian Minghuan-B31939)
Date: Tue, 9 Sep 2014 19:16:01 +0000
Subject: =?UTF-8?B?562U5aSNOiBbUEFUQ0ggMi8yXSBQQ0k6IExheWVyc2NhcGU6IEE=?=
 =?UTF-8?B?ZGQgTGF5ZXJzY2FwZSBQQ0llIGRyaXZlcg==?=
In-Reply-To: <60096763.M59cqLJ4gm@wuerfel>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
 <6844751.zBSvS2zU47@wuerfel> <540F4B23.5040209@freescale.com>
 <60096763.M59cqLJ4gm@wuerfel>
Message-ID: <540F51F1.1060909@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2014?09?09? 10:50, Arnd Bergmann wrote:
> On Tuesday 09 September 2014 18:46:59 Lian Minghuan-B31939 wrote:
>> On 2014?09?09? 09:56, Arnd Bergmann wrote:
>>> On Tuesday 09 September 2014 17:25:57 Lian Minghuan-B31939 wrote:
>>>> [Minghuan] I discussed with my colleague. They worry about performance
>>>> degradation if using regmap API,
>>>> because there are some fast device use scfg. We tend to use a simple way
>>>> to map andread/write scfg directly.
>>> I see. In this case, I would probably create a separate msi controller
>>> driver that owns the "fsl,ls1021a-scfg" device, and is referenced
>>> through the "msi-parent" property in the pcie controller.
>>>
>>> You can use of_pci_find_msi_chip_by_node() to get the msi_chip
>>> instance and then connect that to your pci host. This will also
>>> take care of the case where you may want to use the main GICv3
>>> on a future SoC.
>> [Minghuan] There is something wrong with LS1021A MSI hardware that it
>> only supports one interrupt not 32 interrupts.  Now, I do not want to
>> create a separate msi controller driver just for incorrect hardware.
>> I may provide complete MSI driver for the new hardware when it is ready.
> Would you just leave out MSI support for the LS1021A PCIe variant?
> I guess that's fine because all device drivers should also support
> legacy interrupts and there is no performance gain in MSI in this
> case.
[Minghuan] I have added MSI support for LS1021A PCIe just reserved 31 
interrupts as used.

> 	Arnd
