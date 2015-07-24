From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 24 Jul 2015 18:11:47 +0200
Subject: [PATCH] bcma: populate bus DT subnodes as platform_device-s
In-Reply-To: <871tfzif17.fsf@kamboji.qca.qualcomm.com>
References: <1435504633-20831-1-git-send-email-zajec5@gmail.com>
 <CACna6rzFYpwbzM+s-KzFQmTym4iLVn+Ap+DWgFmAZzhWKTQfJw@mail.gmail.com>
 <871tfzif17.fsf@kamboji.qca.qualcomm.com>
Message-ID: <CAGhQ9VyH4yvnU_kPAy3a7Z+80jNV8uNoTr=Nd=eV2D-iz9YVUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 July 2015 at 08:06, Kalle Valo <kvalo@codeaurora.org> wrote:
> Rafa? Mi?ecki <zajec5@gmail.com> writes:
>
>>> +       if (bus->host_pdev) {
>>> +               struct device *dev = &bus->host_pdev->dev;
>>> +
>>> +               of_platform_populate(dev->of_node, of_default_bus_match_table,
>>> +                                    NULL, dev);
>>> +       }
>>> +
>>
>> This caused a compile error when using bcma as module:
>> ERROR: "of_default_bus_match_table" [drivers/bcma/bcma.ko] undefined!

I encountered the same problem with my modular memory controller driver.

>> There are two options I guess:
>> 1) Export of_default_bus_match_table

See link below for Rob Herring's take on that.
http://marc.info/?l=linaro-kernel&m=143766694414121&w=2


regards,
Joachim Eastwood
