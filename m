From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed, 7 Oct 2015 16:32:16 +0200
Subject: [PATCH v5 3/3] PCI: st: Provide support for the sti PCIe
 controller
In-Reply-To: <5139149.TmJY1YjqAU@wuerfel>
References: <1444118168-13086-1-git-send-email-gabriel.fernandez@linaro.org>
 <1444118168-13086-4-git-send-email-gabriel.fernandez@linaro.org>
 <5139149.TmJY1YjqAU@wuerfel>
Message-ID: <CAG374jAnKQCerh3nBX9WsmwP4g6uPLKPSZ2EhhwPa-i89RsyZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 October 2015 at 23:01, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 06 October 2015 09:56:08 Gabriel Fernandez wrote:
>> +
>> +/*
>> + * On ARM platforms, we actually get a bus error returned when the PCIe IP
>> + * returns a UR or CRS instead of an OK.
>> + */
>> +static int st_pcie_abort_handler(unsigned long addr, unsigned int fsr,
>> +                                struct pt_regs *regs)
>> +{
>> +       return 0;
>> +}
>>
>
> I'm not sure if we discussed this already for this driver. Usually
> you should have a register in the PCI host that you can check to see
> what caused the abort.
>
> Try to make this as narrow as possible so you return nonzero for
> any abort except the one you actually try to prevent.
>
>         Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Hi Arnd,

Yes we already discussed about that:
http://www.spinics.net/lists/arm-kernel/msg393705.html

We can probably improve the abort handling once the patch below will be merged
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/366215.html

As imx6 does the same, does it sound reasonable to keep this approach
of the st driver and start discussing about generic way to handle
abort for DW pci driver ?

Best regards

Gabriel
