From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 25 Aug 2010 11:41:56 +1000
Subject: [PATCH 0/3] Generalise ARM perf-events backend for oprofile
In-Reply-To: <20100823105759.GA18638@infradead.org>
References: <1282560381-7700-1-git-send-email-matt@console-pimps.org>
	<20100823105759.GA18638@infradead.org>
Message-ID: <1282700516.22370.567.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-08-23 at 06:57 -0400, Christoph Hellwig wrote:
> On Mon, Aug 23, 2010 at 11:46:18AM +0100, Matt Fleming wrote:
> > The perf-events backend for OProfile that Will Deacon wrote in
> > 8c1fc96f6fd1f361428ba805103af0d0eee65179 ("ARM: 6072/1: oprofile: use
> > perf-events framework as backend") is of use to more architectures
> > than just ARM. Move the code into drivers/oprofile/ so that SH can use
> > it instead of the nearly identical copy of its OProfile code.
> 
> Nice, I didn't know such a backend already existed.  Now that you
> have made it generic we should aim towards making it the only oprofile
> backend and getting rid of all the duplication.

Even better would be to do the surgery at a higher level and provide the
oprofile API without the oprofile buffer management. My experience is
that it doesn't scale, and on heavily threaded large SMP setup, there is
an enormous amount of time wasted contending on the global oprofile
buffer mutex.

Cheers,
Ben.
