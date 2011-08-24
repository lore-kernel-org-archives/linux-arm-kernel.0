From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed, 24 Aug 2011 18:11:14 +0800
Subject: [PATCH] arm: fix compile failure in orion5x/dns323-setup.c
In-Reply-To: <20110802095604.GA22637@linux-mips.org>
References: <1312216934-29710-1-git-send-email-paul.gortmaker@windriver.com>
	<20110802095604.GA22637@linux-mips.org>
Message-ID: <CAK5ve-L+ZZFD3rQMwp638V+NfrHqth2dAXGEeK+iBzFP-EHOzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

I guess you can add your Ack to Paul's patch here.

Arnd, could you please add this patch into your tree, as it's a
obvious right fixing.

Thanks,
-Bryan

On Tue, Aug 2, 2011 at 5:56 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Aug 01, 2011 at 12:42:14PM -0400, Paul Gortmaker wrote:
>
>> index a6eddae..c105556 100644
>> --- a/arch/arm/mach-orion5x/dns323-setup.c
>> +++ b/arch/arm/mach-orion5x/dns323-setup.c
>> @@ -77,7 +77,7 @@ static int __init dns323_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>> ? ? ? /*
>> ? ? ? ?* Check for devices with hard-wired IRQs.
>> ? ? ? ?*/
>> - ? ? irq = orion5x_pci_map_irq(const dev, slot, pin);
>> + ? ? irq = orion5x_pci_map_irq(dev, slot, pin);
>
> Very obviously correct ...
>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
>
> ?Ralf
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
