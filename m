From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 13 Mar 2014 14:27:39 -0400
Subject: [PATCH v6 4/7] arm64: Add ftrace support
In-Reply-To: <20140313170834.GE25472@mudshark.cambridge.arm.com>
References: <1393564724-3966-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705630-12384-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705630-12384-5-git-send-email-takahiro.akashi@linaro.org>
 <20140313170834.GE25472@mudshark.cambridge.arm.com>
Message-ID: <1394735259.26600.14.camel@pippen.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-03-13 at 17:08 +0000, Will Deacon wrote:

> > +       /*
> > +        * Note:
> > +        * No protection against faulting at *parent, which may be seen
> > +        * on other archs. It's unlikely on AArch64.
> > +        */
> > +       old = *parent;
> > +       *parent = return_hooker;
> 
> return_hook? People might take it personally otherwise ;)

No, return_hooker is consistent with all the other archs. Hey, it's a
rugby position! Note, which I was when I played. ;-)

> 
> > +       trace.func = self_addr;
> 
> in kernel/ftrace/ftrace.c there's an smb_wmb() between setting up
> tracing_graph_pause and setting the ret_stack with a comment saying:
> 
>     /* Make sure the tasks see the -1 first: */
> 
> Why don't we have a corresponding read-barrier here?

The corresponding rmb is in kernel/trace/trace_function_graph
ftrace_push_return_trace().

-- Steve
