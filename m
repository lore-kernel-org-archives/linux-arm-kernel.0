From: olof@lixom.net (Olof Johansson)
Date: Fri, 26 Jul 2013 08:49:43 -0700
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have people
 interested in device tree janitoring / cleanup?]
In-Reply-To: <20130726141016.GF9858@sirena.org.uk>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726080115.GA5436@netboy>
 <1374831744.2923.42.camel@shinybook.infradead.org>
 <20130726130927.GC4219@netboy>
 <20130726141016.GF9858@sirena.org.uk>
Message-ID: <CAOesGMhEr3DiFm5uSgoHPFUMY4jWu4HkeTU2UmOGj=dS75Vk+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 7:10 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 26, 2013 at 03:09:29PM +0200, Richard Cochran wrote:
>
>> Unless I totally misunderstood, the thread is talking about letting
>> established bindings change with each new kernel version.  I am
>> opposed to that.
>
> No, nobody is really saying that is a particularly good idea.  There is
> some debate about how we work out what an established binding is but
> there's no serious suggestion that we don't want stable bindings.

Yes, what Mark said -- _today_ all bindings are subject to change and
can be changed in lockstep with the kernel. This has been necessary as
part of development to sort out all of the various bootstrapping
issues across platforms.

What we're talking about is to end that mode of operation, and moving
over to locking in bindings. Device tree contents, as mentioned
elsewhere, might still be changed just like code is -- bugs are fixed,
etc. But it's time to start locking down the bindings, in particular
no longer change the established ones.

Long term, final goal is likely to be close to what Russell is saying
-- nothing should go into the kernel tree unless the binding is in a
fully stable state. However, we have a transitional period between now
and then, and even when we're at the final state there will be need to
have some sort of sandbox for development and test of future bindings.
Dealing with all that, as well as the actual process for locking in
bindings, is what needs to be sorted out.

I think we're all in agreement that bindings that change over time are
nothing but pain, but we're arguing that in circles anyway.


-Olof
