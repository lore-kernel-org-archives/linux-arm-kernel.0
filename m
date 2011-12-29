From: rabin@rab.in (Rabin Vincent)
Date: Thu, 29 Dec 2011 21:12:28 +0530
Subject: ftrace performance impact with different configuration
In-Reply-To: <CALZhoSRVNp=Sj2u2GHiQhuHOEdrfiM58KzG+RutvJV=8CoCpTQ@mail.gmail.com>
References: <CALZhoSRVNp=Sj2u2GHiQhuHOEdrfiM58KzG+RutvJV=8CoCpTQ@mail.gmail.com>
Message-ID: <CAH+eYFDb4r235jAGjr7j5R5C+9YK9WeXXjVZGWQUB=330sOi0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2011 at 14:08, Lei Wen <adrian.wenl@gmail.com> wrote:
> 2. Seem dynamic ftrace also could involve some penalty for the running
> system, although it patching the running kernel with nop stub...
>
> For the second item, is there anyone done some research before that
> could zero the cost for the running system when the tracing is not
> enabled yet?

One thing that needs to be fixed (for ARM) is that for the new-style
mcounts, the nop that's currently being done is not really a nop -- it
removes the function call, but there is still an unnecessary push/pop
sequence.  This should be modified to have the push {lr} removed too.
(Two instructions replaced instead of one.)
