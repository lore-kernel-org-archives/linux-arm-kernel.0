From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 9 Apr 2012 09:47:38 +0800
Subject: [PATCH v2 5/7] ARM: mmp: append OF support on pxa168
In-Reply-To: <87ty0tznlb.fsf@laptop.org>
References: <1330950111-30797-1-git-send-email-haojian.zhuang@marvell.com>
 <1330950111-30797-6-git-send-email-haojian.zhuang@marvell.com>
 <87ty0tznlb.fsf@laptop.org>
Message-ID: <CAN1soZwQVTEzXid3GwKda42FnNG-vptGT1zUj9TO39GtnswCkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 9, 2012 at 9:43 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Mon, Mar 05 2012, Haojian Zhuang wrote:
>> +static int __init mmp_intc_add_irq_domain(struct device_node *np,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct device_node *parent)
>> +{
>> + ? ? irq_domain_add_simple(np, 0);
>> + ? ? return 0;
>> +}
>> +
>> +static int __init mmp_gpio_add_irq_domain(struct device_node *np,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct device_node *parent)
>> +{
>> + ? ? irq_domain_add_simple(np, IRQ_GPIO_START);
>> + ? ? return 0;
>> +}
>
> This patch was merged for 3.4-rc1, but it fails to compile because Grant
> removed irq_domain_add_simple() in 3.4-rc1.
>
Noticed. I'll fix it.

Best Regards
Haojian
