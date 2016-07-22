From: mirza.krak@gmail.com (Mirza Krak)
Date: Fri, 22 Jul 2016 21:18:37 +0200
Subject: [RFC 6/6] bus: Add support for Tegra NOR controller
In-Reply-To: <dbbb5c9f-8c67-9d9f-171b-64cd18353411@nvidia.com>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-7-git-send-email-mirza.krak@gmail.com>
 <f6df33eb-53ae-699b-9e1f-69eb7fed7da0@nvidia.com>
 <CALw8SCVy4ud5_+gS3C8WeyTCV0m_4R2xjdEY4vCKEq_3-aFanw@mail.gmail.com>
 <dbbb5c9f-8c67-9d9f-171b-64cd18353411@nvidia.com>
Message-ID: <CALw8SCXCdVMKgemEyQ-MZbxdthkPCDVzi+3boqtXk1_XNjcz4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-07-22 11:38 GMT+02:00 Jon Hunter <jonathanh@nvidia.com>:
>>> The driver should have a remove function given that we can build as a
>>> module.
>>
>> At the moment I do not know what we would do in a remove function and
>> hence me not adding one.
>
> Should just be the inverse of the probe (although there is no inverse
> for the parsing DT bit). If you don't wish to add a remove, that is
> fine, but make the driver a 'bool' and not 'tristate' in the Kconfig so
> it cannot be configured as a module.

I understand the concept of a remove function, but I use devm_ calls
for all resources. These should be handled by the device core on a
driver detach?

One thing came to mind now that could be done in a remove method and
that is clearing the CONFIG_GO bit, or I could just do that first on
probe instead to make sure the controller is stopped.

Ok, one more thing came to mind, and that is depopulating the child
devices. Got it remove function it is then.

>>>> +module_platform_driver_probe(nor_driver, nor_probe);
>>>
>>> I would use "tegra_nor" namespace for all the structs, functions, etc.
>>> However, we may prefer to go with GMI and in which case tegra_gmi_probe,
>>> etc.
>>
>> ACK. Who gets the last call on what we should call the driver? It
>> seems that we both think GMI is a better name, do we need a third? :).
>
> The patches would have to go via Thierry and so ultimately, Thierry.
> However, I can't imagine he would object to GMI ;-)

Eagerly awaiting Thierry`s comments :).

Best Regards,
Mirza
