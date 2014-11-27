From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 27 Nov 2014 09:58:25 -0500
Subject: [PATCH] arm: ftrace: Adds support for ftrace operations
In-Reply-To: <CACh+v5Phr-yA8c_bnooR8eLyEpmiMDwCGi2Oy8ArQayuRbeczA@mail.gmail.com>
References: <1415372352-15664-1-git-send-email-jjhiblot@traphandler.com>
 <20141107115225.72bc6cbf@gandalf.local.home>
 <545CFAF4.8030104@traphandler.com>
 <CACh+v5MDFZj+NOPWdnMgNthn_DxL3nn=CZJ224vMh7hSf84o4Q@mail.gmail.com>
 <20141125182038.04497ec0@gandalf.local.home>
 <CACh+v5Phr-yA8c_bnooR8eLyEpmiMDwCGi2Oy8ArQayuRbeczA@mail.gmail.com>
Message-ID: <20141127095825.37f57197@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Nov 2014 11:23:45 +0100
Jean-Jacques Hiblot <jjhiblot@traphandler.com> wrote:

> 2014-11-26 0:20 GMT+01:00 Steven Rostedt <rostedt@goodmis.org>:
> > On Mon, 24 Nov 2014 10:59:24 +0100
> > Jean-Jacques Hiblot <jjhiblot@traphandler.com> wrote:
> >
> >> Hi Steve,
> >> did you get a chance of running your tests suite on real hardware with
> >> this patch? I'd be really interested in the results.
> >
> > Yes I finally got it working on my beaglebone white. It passed all the
> > tests that passed without it. Although I'm not sure this patch itself
> > was tested as I didn't have kprobes which might use it.
> >
> Thanks for testing it. At least it doesn't cause regression.
> What do you mean by not having krpobes which might use it ? Are you
> thinking of the kprobe optimization based on ftrace ?
> 

Yep. My tests use that. But as ARM doesn't have an mfentry where
functions probed by kprobes at the start are optimized with ftrace, my
tests wont test it.

I also didn't have kprobes enabled on this board. Is it fully supported
in ARM, and does kprobes use it there too?

-- Steve
