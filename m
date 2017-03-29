From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 29 Mar 2017 12:33:30 +0200
Subject: [PATCH] mmc: core: Do not hold re-tuning during CMD6 commands
In-Reply-To: <CAPDyKFoWyVrdk7bG1n=rTSOddvqaj-uTO70QoGmcKQK1Fhio2w@mail.gmail.com>
References: <1490336341-22292-1-git-send-email-chaotian.jing@mediatek.com>
 <1490336341-22292-2-git-send-email-chaotian.jing@mediatek.com>
 <13a83728-0031-5683-c371-4b517df32299@intel.com>
 <1490344369.22814.10.camel@mhfsdcap03>
 <03d54000-9ced-1b31-df80-d254f02433db@intel.com>
 <1490348427.22814.19.camel@mhfsdcap03>
 <CAPDyKFoo5sJ2XtjyiW1DLjhFdJySbDK7+N05vrKpeiZsp25qrA@mail.gmail.com>
 <1490578500.22814.31.camel@mhfsdcap03>
 <CAPDyKFoWyVrdk7bG1n=rTSOddvqaj-uTO70QoGmcKQK1Fhio2w@mail.gmail.com>
Message-ID: <CAPDyKFokoSw+udsGERhz+nJxpj41tVEyhBF9zLJtCU4itahTOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>> Below is the fail log of suspend fail.
>> the normal command tune result should be 0xffffff9ff, but some time, we
>> get the tune result of 0xffffffff, then we choose the 10 as the best
>> tune parameter, which is not stable.
>> I know that we should focus on why we get the result of 0xffffffff, this
>> may be result of device/host timing shifting while tuning. but what I
>> want to do is that when get a response CRC error, we can do re-tune to
>> recovery it, but not only return the -84 and cause suspend fail
>> eventually. if all hardware are perfect, then we don't need the re-tune
>> mechanism.
>
> Thanks for elaborating!
>
> Can you please also tell exactly which of the CMD6 commands in the
> suspend sequence that is triggering this problem? Cache flush? Power
> off notification?

You didn't answer this question. I would really like to know the
sequence of the commands you see that are being sent to the card
during suspend. And of course in particular what command that fails.

[...]

Kind regards
Uffe
