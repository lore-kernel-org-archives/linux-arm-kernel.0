From: pintu_agarwal@yahoo.com (PINTU KUMAR)
Date: Thu, 19 Apr 2012 06:42:21 -0700 (PDT)
Subject: [NEW]: Introducing shrink_all_memory from user space
In-Reply-To: <20120418211032.47b243da@pyramind.ukuu.org.uk>
References: <1334483226.20721.YahooMailNeo@web162003.mail.bf1.yahoo.com>
 <CAFLxGvwJCMoiXFn3OgwiX+B50FTzGZmo6eG3xQ1KaPsEVZVA1g@mail.gmail.com>
 <1334490429.67558.YahooMailNeo@web162006.mail.bf1.yahoo.com>
 <CAFLxGvz5tmEi-39CZbJN+0zNd3ZpHXzZcNSFUpUWS_aMDJ4t6Q@mail.gmail.com>
 <20120418211032.47b243da@pyramind.ukuu.org.uk>
Message-ID: <1334842941.92324.YahooMailNeo@web162006.mail.bf1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>________________________________
>From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>To: richard -rw- weinberger <richard.weinberger@gmail.com>? 
>Sent: Thursday, 19 April 2012 1:40 AM
>Subject: Re: [NEW]: Introducing shrink_all_memory from user space
>
>On Sun, 15 Apr 2012 14:10:00 +0200
>richard -rw- weinberger <richard.weinberger@gmail.com> wrote:
>
>> On Sun, Apr 15, 2012 at 1:47 PM, PINTU KUMAR <pintu_agarwal@yahoo.com> wrote:
>> > Moreover, this is mainly meant for mobile phones where there is only *one* user.
>> 
>> I see. Jet another awful hack.
>> Mobile phones are nothing special. They are computers
>
>Correct - so if it is showing up useful situations then they are also
>useful beyond mobile phone.
>
>> Every program which is allowed to use this interface will (ab)use it.
>
>If you expose it to userspace then you would want it very tightly
>controlled and very much special case. Within the kernel using it
>internally within things like CMA allocators seems to make more sense.
>
>I think you overestimate the abuse. It's an interface which pushes clean
>pages that can be cheaply recovered out of memory. It doesn't guarantee
>the caller reaps the benefit of that, and the vm will continue to try and
>share out any new resource fairly.
>
>Alan

Dear Alan, thank you very much for your comments and suggestion.
My plan is to develop a kind of system utility (like defragment) which we can run from user space (as root).
?
And yes you are right, my future plan is also to use it for CMA as it also suffers from memory fragmentation.
Now I think CMA uses memory compaction solution to reclaim pages for its allocation. Similarly we can use this on top of compaction for better results.
?
And we can even call this from low memory notifier whenever memory pressure falls below watermark and regain memory state as it was before.
?
Well more experiments and findings are in progress.
?
?
?
Thanks,
Pintu
