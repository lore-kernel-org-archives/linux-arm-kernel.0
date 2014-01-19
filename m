From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 20:08:54 +0100
Subject: [RFC v3 11/13] ahci-imx: Don't create a nested platform device
 from probe
In-Reply-To: <20140119122540.GN15937@n2100.arm.linux.org.uk>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-12-git-send-email-hdegoede@redhat.com>
 <20140119122540.GN15937@n2100.arm.linux.org.uk>
Message-ID: <52DC22C6.6040806@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/19/2014 01:25 PM, Russell King - ARM Linux wrote:
> On Sun, Jan 19, 2014 at 12:48:53AM +0100, Hans de Goede wrote:
>> Instead only provide platform_data through of_device_id, like the ahci-sunxi
>> driver does.
>
> It looks like the whole of ahci_imx.c (apart from the inclues) is
> enclosed in a big ifdef.  You can avoid that by using this in the
> Makefile:
>
>> @@ -10,9 +10,8 @@ obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
>>   obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
>>   obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
>>   obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
>> -obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o
>>
>> -ahci_plat-objs := ahci_platform.o ahci_sunxi.o
>> +ahci_plat-objs := ahci_platform.o ahci_imx.o ahci_sunxi.o
>
> ahci_plat-y := ahci_platform.o ahci_sunxi.o
> ahci_plat-$(CONFIG_AHCI_IMX) += ahci_imx.o
>

Ah, good idea, the same goes for the sunxi bits. I'll fix this in the next
revision of the patch-set.

Regards,

Hans
