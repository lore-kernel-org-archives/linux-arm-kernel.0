From: fthain@telegraphics.com.au (Finn Thain)
Date: Fri, 29 Jan 2016 11:13:05 +1100 (AEDT)
Subject: [PATCH] misc: atmel-secumod: Driver for Atmel "security module".
In-Reply-To: <CALnQHM13cGnoma_3erb0oCnRD0sYGGNF1E1cgzCJHrEXbvJpRQ@mail.gmail.com>
References: <1453348655-31182-1-git-send-email-davidm@egauge.net>
 <20160125110921.GA4027@piout.net>
 <CALnQHM13cGnoma_3erb0oCnRD0sYGGNF1E1cgzCJHrEXbvJpRQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1601291055520.23683@nippy.intranet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, 25 Jan 2016, David Mosberger wrote:

> On Mon, Jan 25, 2016 at 4:09 AM, Alexandre Belloni 
> <alexandre.belloni@free-electrons.com> wrote:
> 
> > I know this does more than that but I think those thre sections should 
> > be registered using the nvmem framework. The sysfs file creation and 
> > accesses then comes for free.
> 
> I think Finn's patches would have to go in for that first, since the 
> existing nvram code is a mess. Even with Finn's patches in, I think it 
> could go either way.

I think Alexandre is speaking of the nvmem subsystem (not nvram).
Documentation/devicetree/bindings/nvmem
Documentation/nvmem
drivers/nvmem

> I'm not exactly sure how some of the features of the security module 
> would be used: key management, auto erasing, there is a strange "backup 
> mode" vs "normal mode" which is not well documented, etc.  So I think it 
> may well end up being sufficiently different to warrant a separate 
> driver.

nvmem is not a subsystem I am familiar with, so it's not immediately clear 
to me what your driver would look like if re-written that way.

Maybe it would become simpler. But if you did end up needing a separate 
misc driver as well, maybe use of the nvmem framework would actually 
increase complexity.

It would depend on your requirements. But I would focus on the actual 
requirement rather than uncertain future possibilities.

> 
> > Another idea is also to expose it using a genpool so it can be 
> > accessed as sram from inside the kernel.
> 
> That may be a fine idea, but as far as our application is concerned, we 
> need user-level access to the battery-backed RAM.

Right. I don't see how adding a memory allocator would help either.

-- 

> 
> Best regards,
> 
>   --david
> 
