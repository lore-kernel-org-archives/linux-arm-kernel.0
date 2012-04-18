From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 18 Apr 2012 21:10:32 +0100
Subject: [NEW]: Introducing shrink_all_memory from user space
In-Reply-To: <CAFLxGvz5tmEi-39CZbJN+0zNd3ZpHXzZcNSFUpUWS_aMDJ4t6Q@mail.gmail.com>
References: <1334483226.20721.YahooMailNeo@web162003.mail.bf1.yahoo.com>
 <CAFLxGvwJCMoiXFn3OgwiX+B50FTzGZmo6eG3xQ1KaPsEVZVA1g@mail.gmail.com>
 <1334490429.67558.YahooMailNeo@web162006.mail.bf1.yahoo.com>
 <CAFLxGvz5tmEi-39CZbJN+0zNd3ZpHXzZcNSFUpUWS_aMDJ4t6Q@mail.gmail.com>
Message-ID: <20120418211032.47b243da@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 15 Apr 2012 14:10:00 +0200
richard -rw- weinberger <richard.weinberger@gmail.com> wrote:

> On Sun, Apr 15, 2012 at 1:47 PM, PINTU KUMAR <pintu_agarwal@yahoo.com> wrote:
> > Moreover, this is mainly meant for mobile phones where there is only *one* user.
> 
> I see. Jet another awful hack.
> Mobile phones are nothing special. They are computers

Correct - so if it is showing up useful situations then they are also
useful beyond mobile phone.

> Every program which is allowed to use this interface will (ab)use it.

If you expose it to userspace then you would want it very tightly
controlled and very much special case. Within the kernel using it
internally within things like CMA allocators seems to make more sense.

I think you overestimate the abuse. It's an interface which pushes clean
pages that can be cheaply recovered out of memory. It doesn't guarantee
the caller reaps the benefit of that, and the vm will continue to try and
share out any new resource fairly.

Alan
