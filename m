From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 01 Oct 2012 16:12:09 +0100
Subject: [PATCH 14/15] KVM: ARM: Handle I/O aborts
In-Reply-To: <20121001125326.GA2100@linaro.org>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153559.21241.29970.stgit@ubuntu>
 <20120927151108.GM25916@mudshark.cambridge.arm.com>
 <CANM98qKFKU98EWNaOepjxab3h5vQypxdt_YoJbKV9kd31XUfaw@mail.gmail.com>
 <20121001125326.GA2100@linaro.org>
Message-ID: <1349104329.2160.71.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-10-01 at 13:53 +0100, Dave Martin wrote:
> On Sun, Sep 30, 2012 at 05:49:21PM -0400, Christoffer Dall wrote:
> > On Thu, Sep 27, 2012 at 11:11 AM, Will Deacon <will.deacon@arm.com> wrote:
> > > On Sat, Sep 15, 2012 at 04:35:59PM +0100, Christoffer Dall wrote:
> > > I'm afraid you're not going to thank me much for this, but it's high time we
> > > unified the various instruction decoding functions we have under arch/arm/
> > > and this seems like a good opportunity for that. For example, look at the
> > > following snippets (there is much more in the files I list) in addition to
> > > what you have:
> > >
> > 
> > I think it would be great if we had a set of unified decoding functions!
> > 
> > However, I think it's a shame if we can't merge KVM because we want to
> > clean up this code. There would be nothing in the way of breaking API
> > or anything like that preventing us from cleaning this up after the
> > code has been merged.
> > 
> > Please consider reviewing the code for correctness and consider if the
> > code could be merged as is.
> > 
> > On the other hand, if you or Dave or anyone else wants to create a set
> > of patches that cleans this up in a timely manner, I will be happy to
> > merge them for my code as well ;)
> 
> The time I would have available to put into this is rather limited, but
> I have some initial ideas, as outlined below.
> 
> Tixy (who did the kprobes implementation, which is probably the most
> sophisticated opcode handling we have in the kernel right now) may have
> ideas too.  I would hope that any common framework could reuse a fair
> chunk of his implementation and test coverage.

To my thinking, the kprobes code is very tailored to the job it needs to
do and that turning it into something generic is just going to make
everything bigger and more complex - because a generic framework would
be bigger (as it's trying to be generic) and then things like kprobes
will probably end up having an additional framework layered over the top
to bend it to it's purposes. Perhaps I'm being too pessimistic.

It would also requiring an inordinate amount of time to thrash out
requirements, design, prototype, and to implement. (I don't think I'm
being overly pessimistic about that ;-)

So, unless some-one has serious quantities of spare time lying around...

-- 
Tixy
