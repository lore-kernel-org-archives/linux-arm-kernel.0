From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 2 Apr 2012 21:01:40 -0400
Subject: [PATCH] ARM: versatile: fix build failure in pci.c
In-Reply-To: <CAOMZO5CUktQ78dbpqpepLvQXme7OcaxXnCcDsxZ+JahOjjEt=Q@mail.gmail.com>
References: <1333410505-17257-1-git-send-email-paul.gortmaker@windriver.com>
 <CAOMZO5CUktQ78dbpqpepLvQXme7OcaxXnCcDsxZ+JahOjjEt=Q@mail.gmail.com>
Message-ID: <CAP=VYLpim2TCMO5nDVNe0bdm9ZQ+czUWNpxxWugDzrHO6aYVAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 2, 2012 at 8:03 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Paul.
>
> On Mon, Apr 2, 2012 at 8:48 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
>> commit 9f786d033d025ab7d2c4d1b959aa81d935eb9e19
>>
>> ? ?"arm/PCI: get rid of device resource fixups"
>>
>> causes this failure on the versatile:
>>
>> arch/arm/mach-versatile/pci.c: In function 'pci_versatile_setup_resources':
>> arch/arm/mach-versatile/pci.c:221: error: 'sys' undeclared (first use in this function)
>>
>> because the versatile wasn't passing in the full struct pci_sys_data
>> but only the resource sub-field. ?Change it to pass in the full
>> struct so that sys will be in scope.
>>
>> Reported-by: Bruce Ashfield <bruce.ashfield@windriver.com>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>
> I have also sent a similar patch:
> http://marc.info/?l=linux-arm-kernel&m=133107329108262&w=2

I see.  Well, there weren't any follow ups to it but I would say that
passing both sys->resources and sys both side-by-side at the same
time doesn't really make sense.  I think just passing in sys by itself
as I did is a cleaner way to go, wouldn't you agree?

Thanks,
Paul.

>
> Regards,
>
> Fabio Estevam
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
