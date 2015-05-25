From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 May 2015 22:29:40 +0200
Subject: [RFC PATCH 2/2] arm64: Implement vmalloc based thread_info
 allocator
In-Reply-To: <F68D2983-226C-4704-A1E0-E79C9425B822@foss.arm.com>
References: <1432483340-23157-1-git-send-email-jungseoklee85@gmail.com>
 <B873B881-4972-4524-B1D9-4BB05D7248A4@gmail.com>
 <F68D2983-226C-4704-A1E0-E79C9425B822@foss.arm.com>
Message-ID: <5601369.jDWtB6nFJC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 May 2015 19:47:15 Catalin Marinas wrote:
> On 25 May 2015, at 13:01, Jungseok Lee <jungseoklee85@gmail.com> wrote:
> 
> >> Could the stack size be reduced to 8KB perhaps?
> > 
> > I guess probably not.
> > 
> > A commit, 845ad05e, says that 8KB is not enough to cover SpecWeb benchmark.
> 
> We could go back to 8KB stacks if we implement support for separate IRQ 
> stack on arm64. It's not too complicated, we would have to use SP0 for (kernel) threads 
> and SP1 for IRQ handlers.

I think most architectures that see a lot of benchmarks have moved to
irqstacks at some point, that definitely sounds like a useful idea,
even if the implementation turns out to be a bit more tricky than
what you describe.

There are a lot of workloads that would benefit from having lower
per-thread memory cost.

	Arnd
