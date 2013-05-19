From: rostedt@goodmis.org (Steven Rostedt)
Date: Sun, 19 May 2013 16:23:22 -0400
Subject: [PATCH v2 10/10] kernel: might_fault does not imply might_sleep
In-Reply-To: <20130519164009.GA2434@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <1f85dc8e6a0149677563a2dfb4cef9a9c7eaa391.1368702323.git.mst@redhat.com>
 <20130516184041.GP19669@dyad.programming.kicks-ass.net>
 <20130519093526.GD19883@redhat.com>
 <1368966844.6828.111.camel@gandalf.local.home>
 <20130519133418.GA24381@redhat.com>
 <1368979579.6828.114.camel@gandalf.local.home>
 <20130519164009.GA2434@redhat.com>
Message-ID: <1368995002.6828.117.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-05-19 at 19:40 +0300, Michael S. Tsirkin wrote:

> OK I get it. So let me correct myself. The simple code
> that does something like this under a spinlock:
> >       preempt_disable
> >       pagefault_disable
> >       error = copy_to_user
> >       pagefault_enable
> >       preempt_enable
> >
> is not doing anything wrong and should not get a warning,
> as long as error is handled correctly later.
> Right?

I came in mid thread and I don't know the context. Anyway, the above
looks to me as you just don't want to sleep. If you try to copy data to
user space that happens not to be currently mapped for any reason, you
will get an error. Even if the address space is completely valid. Is
that what you want?

-- Steve
