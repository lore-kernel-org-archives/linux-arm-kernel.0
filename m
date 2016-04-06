From: julien.grall@arm.com (Julien Grall)
Date: Wed, 6 Apr 2016 18:45:19 +0100
Subject: [PATCH v5 6/9] irqchip/gic-v3: Parse and export virtual GIC
 information
In-Reply-To: <20160406172228.GE8961@cbox>
References: <1459769860-6629-1-git-send-email-julien.grall@arm.com>
 <1459769860-6629-7-git-send-email-julien.grall@arm.com>
 <20160406172228.GE8961@cbox>
Message-ID: <57054B2F.8040907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 06/04/2016 18:22, Christoffer Dall wrote:
> On Mon, Apr 04, 2016 at 12:37:37PM +0100, Julien Grall wrote:
>> +static void __init gic_acpi_setup_kvm_info(void)
>> +{
>> +	int irq;
>> +
>> +	if (!gic_acpi_collect_virt_info()) {
>> +		pr_warn("Unable to get hardware information used for virtualization\n");
>
> perhaps this should say something about gicv3 as well?

Actually, none of the pr_* call contain GICv3 and there is no pr_fmt.

I'm thinking to send a patch to add pr_fmt in the GICv3 driver.

>
> Otherwise (with my extremely limited acpi understanding):
>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Thank you!

Regards,

-- 
Julien Grall
