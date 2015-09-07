From: majun258@huawei.com (majun (F))
Date: Mon, 7 Sep 2015 09:17:01 +0800
Subject: [PATCH v4 1/2] Add the driver of mbigen interrupt controller
In-Reply-To: <CALW4P+KQEJsKCbnXeyup2Z2vNGY9jXKZKafQ+hSvc5_U5O+vtQ@mail.gmail.com>
References: <CALW4P+JABDw=dOtpC1MgEjXt7hN4Pm1f4NPDna9XYoE+yc=Grg@mail.gmail.com>
 <55E50344.9090104@huawei.com>
 <CALW4P+KQEJsKCbnXeyup2Z2vNGY9jXKZKafQ+hSvc5_U5O+vtQ@mail.gmail.com>
Message-ID: <55ECE58D.6050602@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexey:

? 2015/9/4 8:56, Alexey Klimov ??:
> Hi Ma Jun,
> 
> On Tue, Sep 1, 2015 at 4:45 AM, majun (F) <majun258@huawei.com> wrote:
>> Hi Alexey:
>>
[...]
>>>> +       mgn_chip->base = base;
>>>> +       mgn_chip->node = node;
>>>> +
>>>> +       domain = irq_domain_add_tree(node, &mbigen_domain_ops, mgn_chip);
>>>> +       mgn_chip->domain = domain;
>>>> +
>>>> +       raw_spin_lock_init(&mgn_chip->lock);
>>>> +       INIT_LIST_HEAD(&mgn_chip->entry);
>>>> +       INIT_LIST_HEAD(&mgn_chip->mbigen_device_list);
>>>> +
>>>> +       for_each_child_of_node(node, child) {
>>>> +               mbigen_device_init(mgn_chip, child);
>>>
>>> You don't check error from mbigen_device_init()
>> I don't think we need to check errors here.
>> mbigen_device_init() handle all errors.
> 
> For my eyes, mbigen_device_init() is static and used only once here.
> Here you don't check return value from it. If this is correct you can
> convert mbigen_device_init() to return void unless you have future
> plans to modify it.
> 
> Or you have option to check return value here and add error path.

Ok, This will be changed in next version.

> 
> Please add me to cc to next version of patch set which I guess will be v5.
> 

Got it. I will add you to cc list in next version.
Thanks for you review !

Ma Jun
