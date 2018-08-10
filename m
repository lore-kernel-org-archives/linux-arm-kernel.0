From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 10 Aug 2018 18:17:47 +0200
Subject: [PATCH v2 14/29] net: simplify eth_platform_get_mac_address()
In-Reply-To: <CAHp75Ve28aNe+FCK3p4OLsDf7dNo-iJ1VR=pyx+Y9OUn3sjYBw@mail.gmail.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-15-brgl@bgdev.pl>
 <CAHp75Ve28aNe+FCK3p4OLsDf7dNo-iJ1VR=pyx+Y9OUn3sjYBw@mail.gmail.com>
Message-ID: <CAMRc=Mc536v+L_u0garWbeyQ78Q6tyEEzhR9pRGf5mBU+daE+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-08-10 16:39 GMT+02:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Fri, Aug 10, 2018 at 11:05 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We don't need to use pci_device_to_OF_node() - we can retrieve
>> dev->of_node directly even for pci devices.
>>
>
>>         struct device_node *dp;
>>
>> -       if (dev_is_pci(dev))
>> -               dp = pci_device_to_OF_node(to_pci_dev(dev));
>> -       else
>> -               dp = dev->of_node;
>> -
>> +       dp = dev->of_node;
>>         addr = NULL;
>>         if (dp)
>>                 addr = of_get_mac_address(dp);
>
> Looking more at this I could even propose to change all above by
>
> addr = device_get_mac_address(dev, mac_addr, ETH_ALEN);
>
> Thoughts?
>
> --
> With Best Regards,
> Andy Shevchenko

Indeed seems like it's even more generalized. Thanks for spotting that.

Bart
