From: mkl0301@gmail.com (Lin Mac)
Date: Mon, 10 Jan 2011 23:47:29 +0800
Subject: [PATCH v5 3/3] ahci_platforms: add support for CNS3xxx SoC devices
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0373E1D99B@dbde02.ent.ti.com>
References: <1294557970-654-1-git-send-email-mkl0301@gmail.com>
	<1294557970-654-4-git-send-email-mkl0301@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0373E1D99B@dbde02.ent.ti.com>
Message-ID: <AANLkTikrFpD+MDqyjS3CMGceMHXWhELPGNv1FaqEqP0s@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/10 Basheer, Mansoor Ahamed <mansoor.ahamed@ti.com>:
>> From: Mac Lin <mkl0301@gmail.com>
>>
>> CNS3xxx override the softreset function of ahci_platform
>> ahci_softreset by cns3xxx_ahci_softreset, which would retry
>> ahci_do_softreset again with pmp=0 if
>> pmp=15 failed, for the controller has problem receiving D2H
>> Reg FIS of the different PMP setting of the previous sent H2D Reg FIS.
>>
>
> Is this issue only with your ahci platform controller? I came across another
> thread here,
>
> http://www.spinics.net/lists/linux-ide/msg39865.html
Thanks for mentioning this.
They do look alike. I'll confirm with them.

> Also, the ahci platform controller on Texas Instruments OMAP L138 platform
> behaves in a similar fashion.
>
> Currently I see only Cavium Networks, Faraday and TI using ahci platform
> controller and all 3 facing same issue.
>
> Hence, should we fix this in ahci_platform.c conditionally using platform data,
> otherwise we will end-up adding file for every platform (just for one
> function).
We can add quirk in ahci platform data, just like sdhci_pltfm.c and
sdhci_cns3xxx.c.
Thus, in cns3xxx's case, all we need is to include
<linux/ahci_platform.h>, and all the SoC specific code could exist in
arch folder, similar to my v1 patchset.

Best Regards,
Mac Lin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-libahci-Fixup-for-softwreset-failures-with-direct-co.patch
Type: text/x-diff
Size: 1002 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110110/acb4bf7f/attachment.bin>
