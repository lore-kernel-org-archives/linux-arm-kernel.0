From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 24 Aug 2016 00:43:07 +0800
Subject: [PATCH -next] ARM: pxa: remove duplicated include from spitz.c
In-Reply-To: <87y43npi5l.fsf@belgarion.home>
References: <1471965498-7824-1-git-send-email-weiyj.lk@gmail.com>
 <87y43npi5l.fsf@belgarion.home>
Message-ID: <5b9111f3-1c9d-f551-af06-566adceaef38@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,
 

On 08/24/2016 12:24 AM, Robert Jarzmik wrote:
> Wei Yongjun <weiyj.lk@gmail.com> writes:
>
>> Remove duplicated include.
> How so duplicated ? Can you elaborate please ?
>
> Moreover, how do you do think symbol_get() can stay in spitz.c without having
> this include ?

file linux/module.h included twice as following:

#include <linux/kernel.h>
#include <linux/module.h>       /* symbol_get ; symbol_put */
...
#include <linux/module.h>

So I think we can remove the dup include.

Regards,
Wei Yongjun
