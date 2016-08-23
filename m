From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 23 Aug 2016 19:20:27 +0200
Subject: [PATCH -next] ARM: pxa: remove duplicated include from spitz.c
In-Reply-To: <5b9111f3-1c9d-f551-af06-566adceaef38@gmail.com> (Wei Yongjun's
 message of "Wed, 24 Aug 2016 00:43:07 +0800")
References: <1471965498-7824-1-git-send-email-weiyj.lk@gmail.com>
 <87y43npi5l.fsf@belgarion.home>
 <5b9111f3-1c9d-f551-af06-566adceaef38@gmail.com>
Message-ID: <87poozpfl0.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wei Yongjun <weiyj.lk@gmail.com> writes:

> Hi Robert,
> On 08/24/2016 12:24 AM, Robert Jarzmik wrote:
>> Wei Yongjun <weiyj.lk@gmail.com> writes:
>>
>>> Remove duplicated include.
>> How so duplicated ? Can you elaborate please ?
>>
>> Moreover, how do you do think symbol_get() can stay in spitz.c without having
>> this include ?
>
> file linux/module.h included twice as following:
>
> #include <linux/kernel.h>
> #include <linux/module.h>       /* symbol_get ; symbol_put */
> ...
> #include <linux/module.h>
>
> So I think we can remove the dup include.

Ah I see it now.

What you really mean is that you want to revert 12beb346710b ("Merge tag
'pxa-fixes-v4.8' of https://github.com/rjarzmik/linux into randconfig-4.8"),
because :
 - I wasn't carefull enough at review time of
   https://github.com/rjarzmik/linux/commit/5351ca4e70f30e0175265fbf98691528b9a4e990
   https://github.com/rjarzmik/linux/commit/a3c747b96df66a7eb810fef45f3b9e65614712d9
 
 - and because Paul wasn't very carefull when we look at :
   73017a542fd2 ("arm: fix implicit module.h users by adding it to arch/arm as
   required.")

So all in all, I'd prefer a revert with Paul's ack please.
And this time I'll go through my pxa/for-next tree, I was a fool to put that in
pxa/fixes.

Cheers.

-- 
Robert
