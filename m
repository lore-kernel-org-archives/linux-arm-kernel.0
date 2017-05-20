From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 20 May 2017 07:43:15 +0100
Subject: [PATCH 3/3][v4] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <b3980350-9663-d98b-6533-fd3c15f98671@gmail.com> (Matthias
 Brugger's message of "Fri, 19 May 2017 15:41:43 +0200")
References: <20170519131305.5068-1-laurentiu.tudor@nxp.com>
 <20170519131305.5068-4-laurentiu.tudor@nxp.com>
 <b3980350-9663-d98b-6533-fd3c15f98671@gmail.com>
Message-ID: <86tw4g6nb0.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19 2017 at 02:41:43 PM, Matthias Brugger <matthias.bgg@gmail.com> wrote:
> On 19/05/17 15:13, laurentiu.tudor at nxp.com wrote:
>> From: Stuart Yoder <stuart.yoder@nxp.com>
>>
>> Move the source files out of staging into their final locations:
>>    -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
>>    -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
>
> This driver has as compatible "arm,gic-v3-its". I wonder if this is
> correct and if it should be moved like this out of staging.

This is no different from the way we handle *any* bus that uses the
GICv3 ITS as an MSI controller. Each bus provides its glue code that
latches onto the ITS node, and calls into the generic code.

Now, when it comes to moving this out of staging, here is my concern:
There is mention of a userspace tool (restool) used to control the
HW. Where is this tool? Where is the user ABI documented?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
