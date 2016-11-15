From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 15 Nov 2016 10:23:42 -0500
Subject: [PATCH V7 1/3] tracing: add a possibility of exporting function
 trace to other places instead of ring buffer only
In-Reply-To: <CAG2=9p-2ZU3Zk0musHcwAEk4nM6RR0U7JhgyjZ+zjLaVLwz1ig@mail.gmail.com>
References: <1476778140-10319-1-git-send-email-zhang.chunyan@linaro.org>
 <1476778140-10319-2-git-send-email-zhang.chunyan@linaro.org>
 <20161018114418.3445c390@gandalf.local.home>
 <CAG2=9p_SKF4TAbbqF6L4u=y9-_m73vZJ3tOAbRKHCT0MOsLwGQ@mail.gmail.com>
 <20161114105926.7bc7844b@gandalf.local.home>
 <CAG2=9p-2ZU3Zk0musHcwAEk4nM6RR0U7JhgyjZ+zjLaVLwz1ig@mail.gmail.com>
Message-ID: <20161115102342.7ad27130@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Nov 2016 16:14:29 +0800
Chunyan Zhang <zhang.chunyan@linaro.org> wrote:

>
> > Then why have a
> >
> >         if (export->write)
> >
> >
> > Is there every going to be a case where export will not have a write
> > function?  
> 
> There shouldn't be.
> 
> I can move this if statement to the register_ftrace_export() to ensure
> users won't wrongly use it, that's saying the write() of trace_export
> has been set before being registered to 'ftrace_exports_list'.
> 

Looks like it's already there:

+int register_ftrace_export(struct trace_export *export)
+{
+	if (WARN_ON_ONCE(!export->write))
+		return -1;


-- Steve
