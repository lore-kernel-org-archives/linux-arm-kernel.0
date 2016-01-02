From: andrea.merello@gmail.com (Andrea Merello)
Date: Sat, 2 Jan 2016 17:05:34 +0100
Subject: [PATCH 2/4] irqchip: bcm2836: Add SMP support for the 2836
In-Reply-To: <20160102102747.GO8644@n2100.arm.linux.org.uk>
References: <1451166444-11044-1-git-send-email-eric@anholt.net>
 <1451166444-11044-3-git-send-email-eric@anholt.net>
 <20160102102747.GO8644@n2100.arm.linux.org.uk>
Message-ID: <CAN8YU5N+5XH9npZ8Y4GzNi_iskyap=4wBgSn0L4gF80qf7CicQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Agreed.
This probably comes from the downstream code, I think.. But I agree
it's actually redundant.

Thank you for pointing this out.

On Sat, Jan 2, 2016 at 11:27 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Dec 26, 2015 at 01:47:22PM -0800, Eric Anholt wrote:
>> +int __init bcm2836_smp_boot_secondary(unsigned int cpu,
>> +                                   struct task_struct *idle)
>> +{
>> +     unsigned long secondary_startup_phys =
>> +             (unsigned long)virt_to_phys((void *)secondary_startup);
>> +
>> +     dsb();
>> +     writel(secondary_startup_phys,
>> +            intc.base + LOCAL_MAILBOX3_SET0 + 16 * cpu);
>
> Please explain why you need this dsb() - I can't see a reason for it.
> writel() has a barrier internally prior to writing the register, and
> therefore I think the above dsb() is entirely redundant.
>
> --
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
