From: r64343@freescale.com (Liu Hui-R64343)
Date: Mon, 1 Jul 2013 10:37:12 +0000
Subject: [PATCH] ARM: smp_twd: twd_update_frequency need be run on all
 online CPUs
In-Reply-To: <51CADE8A.7010008@de.bosch.com>
References: <1371079180-22344-1-git-send-email-r64343@freescale.com>
 <20130617073120.GA4537@S2101-09.ap.freescale.net>
 <AD13664F485EE54694E29A7F9D5BE1AF84939C@039-SN2MPN1-022.039d.mgd.msft.net>
 <51CADE8A.7010008@de.bosch.com>
Message-ID: <AD13664F485EE54694E29A7F9D5BE1AF8729B7@039-SN2MPN1-022.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Dirk Behme [mailto:dirk.behme at de.bosch.com]
>Sent: Wednesday, June 26, 2013 8:29 PM
>To: Liu Hui-R64343; Mike Turquette
>Cc: Shawn Guo; Linus Walleij; rob.herring at calxeda.com; Russell King -
>ARM Linux; linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCH] ARM: smp_twd: twd_update_frequency need be run on
>all online CPUs
>
>On 17.06.2013 10:11, Liu Hui-R64343 wrote:
>>> -----Original Message-----
>>> From: Shawn Guo [mailto:shawn.guo at linaro.org]
>>> Sent: Monday, June 17, 2013 3:31 PM
>>> To: Liu Hui-R64343
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Subject: Re: [PATCH] ARM: smp_twd: twd_update_frequency need be run
>>> on all online CPUs
>>>
>>> On Thu, Jun 13, 2013 at 07:19:40AM +0800, Jason Liu wrote:
>>>> When the local timer freq changed, the twd_update_frequency function
>>>> should be run all the CPUs include itself, otherwise, the twd freq
>>>> will not get updated and the local timer will not run correcttly.
>>>>
>>>> smp_call_function will run functions on all other CPUs, but not
>>>> include himself, this is not correct,use on_each_cpu instead to fix
>>> this issue.
>>>>
>>>> Signed-off-by: Jason Liu <r64343@freescale.com>
>>>> Cc: Russell King <linux@arm.linux.org.uk>
>>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>>> Cc: Rob Herring <rob.herring@calxeda.com>
>>>> Cc: Shawn Guo <shawn.guo@linaro.org>
>>>
>>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>>
>> Thanks Shawn.
>>
>>>
>>> BTW, is there anything wrong with your mailer (git send-email command
>>> line)?  I do not see people you put on Cc tag here show up in Cc of
>>> the email.  And that might the be reason why people are not
>>> responding so far.
>>
>> Yes, there is one issue in my script and get fixed. I will put the
>> patch Into Russell's patch tracking system after Mike and Russell
>> reviewed it And also Cc stable kernel as Linus W. said.
>
>Any news on this?

I have put the patch into Russell's patch tracking system. 

>
>Thanks
>
