From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Wed, 14 May 2014 13:04:17 +0530
Subject: [PATCH v6 0/5] MCPM backend for Exynos5420
In-Reply-To: <alpine.LFD.2.11.1405140031490.980@knanqh.ubzr>
References: <1399982324-27879-1-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1405131325060.980@knanqh.ubzr>
 <CAM4voanvVwj+FuWazTGMHMnM64Cw_qK03D3o=raS43f_zWFfog@mail.gmail.com>
 <alpine.LFD.2.11.1405140031490.980@knanqh.ubzr>
Message-ID: <CAM4voa=6osyXYg_XF=XuGRYmxLDUO+5=-i+cMrNW92fzBZJjfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

[...]
>>
>> 1) can't create /sys/devices/system/cpu/cpu//online: nonexistent directory
>
> What do you get if you do:
>
> $ ls -d /sys/devices/system/cpu/cpu?/online
ls: /sys/devices/system/cpu/cpu//online: No such file or directory
>
> ?
>
>> 2) sleep: invalid number '.0026736'
>
> A sufficiently recent coreutils package should have a sleep command that
> accepts fractional values.  Alternatively you may replace it with
> usleep:
>
>         usleep $RANDOM
Looks like my cramfs needs an update, it seems to have old packages.
>
>> For 1) the cpu number is not being appended. if I give a particular
>> cpu in the script then hotplug in/out works fine.
>> For 2) a constant msleep 10 works.
>
> If you have msleep but not usleep then try:
>
>                 msleep $(($RANDOM / 1000))
I have msleep present.
>
>> Is it OK for me to modify the script to hotplug in/off a randomly chosed core ?
>
> No.  They must *all* be hotplugged simultaneously with some random
> timing.
OK.

Regards,
Abhilash
