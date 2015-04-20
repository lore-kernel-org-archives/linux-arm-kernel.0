From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Apr 2015 20:22:44 +0100
Subject: [PATCH] arm64: kill flush_cache_all()
In-Reply-To: <CAKv+Gu_6u6wZrd=3z94Wqrab=G=bxm30=zWK0Rry3w+F92Wn9w@mail.gmail.com>
References: <1429521875-16893-1-git-send-email-mark.rutland@arm.com>
 <CAKv+Gu-VVA+wruJgfWksFdL5eXrp5nZV-b9q7eYspfi=KoqvEg@mail.gmail.com>
 <20150420180255.GB17767@leverpostej>
 <CAKv+Gu_6u6wZrd=3z94Wqrab=G=bxm30=zWK0Rry3w+F92Wn9w@mail.gmail.com>
Message-ID: <20150420192243.GA8040@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Does that address your concerns? Or pose new questions? ;)
> >
> 
> Crystal clear. Lately I have been dealing with some dodgy Tianocore
> code that 'promoted' VA operations to set/way operations if the VA
> range exceeded a certain size threshold (and nuked the whole cache
> instead), so by now I am well aware of the differences. I was just
> vaguely under the impression that clearing the C bit could result in
> the caches to lose state, but apparently not.

To the best of my knowledge, that is not permitted.

> So that means the EFI stub entry code is sound, and I have no
> objections whatsoever to removing flush_cache_all() et al

Great! Can I consider that an Acked-by?

Thanks,
Mark.
