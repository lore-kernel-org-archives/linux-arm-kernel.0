From: r64343@freescale.com (Liu Hui-R64343)
Date: Fri, 14 Jun 2013 10:02:32 +0000
Subject: [PATCH] ARM: smp_twd: twd_update_frequency need be run on all
 online CPUs
In-Reply-To: <CACRpkdanMh=etQncxr7ekyiA_78buN6_sjvP5zEuoKbS3-JPFQ@mail.gmail.com>
References: <1371079180-22344-1-git-send-email-r64343@freescale.com>
 <CACRpkdanMh=etQncxr7ekyiA_78buN6_sjvP5zEuoKbS3-JPFQ@mail.gmail.com>
Message-ID: <AD13664F485EE54694E29A7F9D5BE1AF82F778@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Linus Walleij [mailto:linus.walleij at linaro.org]
>Sent: Thursday, June 13, 2013 4:00 PM
>To: Liu Hui-R64343; Mike Turquette
>Cc: linux-arm-kernel at lists.infradead.org; Russell King - ARM Linux
>Subject: Re: [PATCH] ARM: smp_twd: twd_update_frequency need be run on
>all online CPUs
>
>On Thu, Jun 13, 2013 at 1:19 AM, Jason Liu <r64343@freescale.com> wrote:
>
>> When the local timer freq changed, the twd_update_frequency function
>> should be run all the CPUs include itself, otherwise, the twd freq
>> will not get updated and the local timer will not run correcttly.
>>
>> smp_call_function will run functions on all other CPUs, but not
>> include himself, this is not correct,use on_each_cpu instead to fix
>this issue.
>>
>> Signed-off-by: Jason Liu <r64343@freescale.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: stable at vger.kernel.org
>
>Mike Turquette wrote this code, so let him look at it.

Mike, could you please look at it?

>
>But it makes sense to me:
>Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Linus W.

>
>Please mark this for stable and put it into Russell's patch tracker
>after allowing some time for others to have a look.

Sure, Will do it after others look at it. 

>
>Yours,
>Linus Walleij
