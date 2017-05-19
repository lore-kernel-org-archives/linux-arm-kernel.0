From: b08248@gmail.com (Stuart Yoder)
Date: Fri, 19 May 2017 17:57:27 -0500
Subject: [PATCH 3/3][v4] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <b3980350-9663-d98b-6533-fd3c15f98671@gmail.com>
References: <20170519131305.5068-1-laurentiu.tudor@nxp.com>
 <20170519131305.5068-4-laurentiu.tudor@nxp.com>
 <b3980350-9663-d98b-6533-fd3c15f98671@gmail.com>
Message-ID: <CALRxmdD=vvVykV8KOKcMT18VkDeZo08_p325mXp_QyuxcH_EBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 8:41 AM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
> On 19/05/17 15:13, laurentiu.tudor at nxp.com wrote:
>>
>> From: Stuart Yoder <stuart.yoder@nxp.com>
>>
>> Move the source files out of staging into their final locations:
>>    -include files in drivers/staging/fsl-mc/include go to
>> include/linux/fsl
>>    -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
>
>
> This driver has as compatible "arm,gic-v3-its". I wonder if this is correct
> and if it should be moved like this out of staging.

Matthias, can you be more specific as to what your concern is?

The fsl-mc bus needs to implement bus specific gic-v3 MSI support just
like the other
bus types.  See:
   drivers/irqchip/irq-gic-v3-its-pci-msi.c
   drivers/irqchip/irq-gic-v3-its-platform-msi.c

You will see that the PCI and platform bus types also find the gic-v3 node by
compatible string.

The bus specific gic-v3 support for fsl-mc is implemented in a
completely standard way.

Thanks,
Stuart
