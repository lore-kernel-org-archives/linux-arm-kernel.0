From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 24 Feb 2012 12:29:42 +0530
Subject: [PATCH 2/6] ARM: OMAP4 PM: Add IO Daisychain support
In-Reply-To: <CAMQu2gxWYVPMBkj0oD=Cj5r1O+X4Y-Lgpntsvc+Jxj3X6XyviQ@mail.gmail.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
 <1330003320-17400-3-git-send-email-t-kristo@ti.com>
 <CAMQu2gxWYVPMBkj0oD=Cj5r1O+X4Y-Lgpntsvc+Jxj3X6XyviQ@mail.gmail.com>
Message-ID: <4F47355E.3090107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 February 2012 07:18 PM, Shilimkar, Santosh wrote:
> On Thu, Feb 23, 2012 at 6:51 PM, Tero Kristo<t-kristo@ti.com>  wrote:
[..]
>>
>> +/**
>> + * Maximum time(us) it takes to output the signal WUCLKOUT of the last pad of
>> + * the I/O ring after asserting WUCLKIN high
>> + */
>> +#define MAX_IOPAD_LATCH_TIME 1000
>> +
> Is the 1000 us/ms ?

1000 us.

> Is that documented or arbitrary chosen ?

looks like it was arbitrarily chosen as there's no documentation
on the worst case delay. I spoke to Nilesh (copied) and he suggested
using a value close to 100us instead which should be quite safe.
1000us according to him is really very high.
however there does not seem to be any documented value available for
this in any of the specs.

>
> Rest of the change looks good to me.
>
> regards
> santosh
