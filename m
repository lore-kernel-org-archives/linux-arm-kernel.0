From: kvalo@codeaurora.org (Kalle Valo)
Date: Thu, 23 Jul 2015 09:06:28 +0300
Subject: [PATCH] bcma: populate bus DT subnodes as platform_device-s
In-Reply-To: <CACna6rzFYpwbzM+s-KzFQmTym4iLVn+Ap+DWgFmAZzhWKTQfJw@mail.gmail.com>
 (=?utf-8?Q?=22Rafa=C5=82_Mi=C5=82ecki=22's?= message of "Thu, 23 Jul 2015
 02:30:41 +0200")
References: <1435504633-20831-1-git-send-email-zajec5@gmail.com>
 <CACna6rzFYpwbzM+s-KzFQmTym4iLVn+Ap+DWgFmAZzhWKTQfJw@mail.gmail.com>
Message-ID: <871tfzif17.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rafa? Mi?ecki <zajec5@gmail.com> writes:

>> +       if (bus->host_pdev) {
>> +               struct device *dev = &bus->host_pdev->dev;
>> +
>> +               of_platform_populate(dev->of_node, of_default_bus_match_table,
>> +                                    NULL, dev);
>> +       }
>> +
>
> This caused a compile error when using bcma as module:
> ERROR: "of_default_bus_match_table" [drivers/bcma/bcma.ko] undefined!
>
> There are two options I guess:
> 1) Export of_default_bus_match_table
> 2) Use some better condition like
> if (IS_BUILTIN(CONFIG_BCMA) && bus->host_pdev)
>
> Unfortunately I'm on my long holidays right now.
>
> Hauke: do you think you can find a moment to handle this?

I can cook up a patch which uses IS_BUILTIN() so that we get the build
working again. You can fix this better once you come back.

> Sorry for the problem :|

No worries, enjoy your vacation :)

-- 
Kalle Valo
