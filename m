From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 05 Dec 2013 21:51:39 +0800
Subject: [RFC part1 PATCH 5/7] ARM64 / ACPI: Introduce arm_core.c and
 its related head file
In-Reply-To: <201312050438.05117.arnd@arndb.de>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-6-git-send-email-hanjun.guo@linaro.org>
 <201312050438.05117.arnd@arndb.de>
Message-ID: <52A084EB.5010103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?12?05? 11:38, Arnd Bergmann wrote:
> On Tuesday 03 December 2013, Hanjun Guo wrote:
>> +static unsigned int gsi_to_irq(unsigned int gsi)
>> +{
>> +       int irq = irq_create_mapping(NULL, gsi);
>> +
>> +       return irq;
>> +}
> I think this could use a comment regarding your plans for IRQ domains.
>
> Do you expect that all ACPI systems would have only a single GIC IRQ
> controller and a single domain, or do you plan to add irqdomain code
> later?

we added irqdomain code in the part2 patch set, is that the code ok
with you?

Thanks
Hanjun
