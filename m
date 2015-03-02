From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 2 Mar 2015 08:30:19 +0000
Subject: [PATCH v3 0/4] clk: st: New always-on clock domain
In-Reply-To: <87sidq3ox8.fsf@free.fr>
References: <1424799222-9301-1-git-send-email-lee.jones@linaro.org>
 <87385r3uk9.fsf@free.fr> <20150227214941.GB12821@x1>
 <87sidq3ox8.fsf@free.fr>
Message-ID: <20150302083019.GD31325@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 28 Feb 2015, Robert Jarzmik wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> 
> >> I wonder why there is a need for a new clock when CLK_IGNORE_UNUSED does
> >> exist. What is the usecase that is covered by this patchset which is not used by
> >> CLK_IGNORE_UNUSED clock flag ?
> >> 
> >> And if that reason exists, I'd like to find it in the commit message.
> >
> > The problem is applying that flag in a generic way.
> >
> > However, I guess you haven't seen this [1] yet?
> >
> > [1] https://lkml.org/lkml/2015/2/27/548
> I have.
> 
> And yet :
>  1) This won't go in a _commit_ message (as opposed to cover-letter). Moreover

Did you read rest of the set, or just the cover-letter?  I referenced
0/0 because it is the thread parent and from there you can drill down
into the commits where I believe there is adequate explanation in
each.  If you could be more specific and tell me which commit you
think requires more explanation, I'd be happy to take a look.

>     it doesn't specify which usecase is not covered by CLK_IGNORE_UNUSED, it
>     says, up to my understanding, that is it another way to have to
>     CLK_IGNORE_UNUSED flag applied.

Well that is exactly what we're doing.  Is there an issue with that?

This is a way to do it at a platform level.  It means we can support
multiple platforms where clocksources have been switched around
without writing new driver code in drivers/clk/st.

If you have something else in mind, let me know.

>  2) I still fail to see why this is necessary
>     IOW why declaring the mandatory always-on clocks with the proper flag should
>     be augmented with a new clock list. Isn't the existing flag the generic way
>     ?

I'm not sure what you mean by this, would you be able to expland a
little?

> I might not understand the real motivation behind that of course, that's why I'm
> asking.

Please bear in mind that we don't supply our clocks statically.  All
of the information is extracted from DT, so if the always-on
information does reside in there, where do you propose it comes from?

We could just write this code inside our own driver and apply the
CLK_IGNORE_UNUSED at a local level, but that's not the generic
solution I am searching for.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
