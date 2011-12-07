From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Dec 2011 10:11:03 +0000
Subject: [RFC v2 1/2] dma-buf: Introduce dma buffer sharing mechanism
In-Reply-To: <CAB2ybb8-0_HupO95UUvLN9ovVxnU+uvn4UXbwqZLSFuC9MZs0w@mail.gmail.com>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <201112051718.48324.arnd@arndb.de>
 <CAB2ybb8-0_HupO95UUvLN9ovVxnU+uvn4UXbwqZLSFuC9MZs0w@mail.gmail.com>
Message-ID: <201112071011.03525.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 December 2011, Semwal, Sumit wrote:
> >
> > Do you have a use case for making the interface compile-time disabled?
> > I had assumed that any code using it would make no sense if it's not
> > available so you don't actually need this.
>
> Ok. Though if we keep the interface compile-time disabled, the users
> can actually check and fail or fall-back gracefully when the API is
> not available; If I remove it, anyways the users would need to do the
> same compile time check whether API is available or not, right?

If you have to do a compile-time check for the config symbol, it's better
to do it the way you did here than in the caller.

My guess was that no caller would actually require this, because when you
write a part of a subsystem to interact with the dma-buf infrastructure,
you would always disable compilation of an extire file that deals with 
everything related to struct dma_buf, not just stub out the calls.

	Arnd
