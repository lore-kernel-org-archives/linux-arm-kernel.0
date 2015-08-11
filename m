From: dann.frazier@canonical.com (Dann Frazier)
Date: Tue, 11 Aug 2015 08:36:57 -0600
Subject: [PATCH v2 0/3] edac: Add L3/SoC support to the APM X-Gene SoC
 EDAC driver
In-Reply-To: <CAPw-ZT=9Eq0yc7tzqJAdCvsQTgRkMmGzNOSXgawBTY0gAijr4Q@mail.gmail.com>
References: <1437808063-17592-1-git-send-email-lho@apm.com>
 <CALdTtnv7P5d0Y6wyKe1SOqXedNhQxMsFZY=m-rxK3zouLcFv-Q@mail.gmail.com>
 <CAPw-ZT=9Eq0yc7tzqJAdCvsQTgRkMmGzNOSXgawBTY0gAijr4Q@mail.gmail.com>
Message-ID: <CALdTtnsfQ1GsZqCN470hdvsJtr_Fi5BU2L1xfAo4cqb=S9yfqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 2:15 PM, Loc Ho <lho@apm.com> wrote:
> Hi Dann,
>
>>> v2:
>>> * Update binding documentation accordingly
>>> * Change all single bit defines to BIT(x)
>>> * Add support for L3 version 1 and 2 HW's
>>> * Change to use debug file system for error injection
>>> * In L3/SoC instance add function, allocate EDAC context after all
>>>   initalization successed
>>> * Support raw or detail info for SoC EDAC error reporting
>>>
>>> v1:
>>> * Add L3/SoC support to the APM X-Gene SoC EDAC driver
>>
>> Loc,
>>   I tested 4.2-rc5 on a Mustang board with one DIMM, and it hangs (RCU
>> stall) in xgene_edac_mc_irq_ctl() on modprobe. Same board with 2 DIMMs
>> boots fine. (U-boot 1.15.12).
>
> I just removed one of the two 16GB DIMM... with 4.2.0-rc1 and some
> code clean up in EDAC driver, it boots just fine... I don't believe
> the code clean up would affect it. Do you have the dump log?
>
> [root at dhcp-10-76-213-247 ~]# uname -a
> Linux dhcp-10-76-213-247 4.2.0-rc1+ #33 SMP PREEMPT Mon Aug 10
> 13:23:03 MDT 2015 aarch64 GNU/Linux

Sure:
  http://paste.ubuntu.com/12055821/
I've reproduced this on two machines. In both cases, we removed the
DIMM furthest from the CPU (in case that matters).

 -dann

> -Loc
