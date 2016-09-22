From: beanhuo@micron.com (Bean Huo (beanhuo))
Date: Thu, 22 Sep 2016 08:36:41 +0000
Subject: ftrace function_graph causes system crash
In-Reply-To: <20160921141705.6ab0be03@gandalf.local.home>
References: <7d0e88fff8e64591ac31be3adbbf763c@SIWEX5A.sing.micron.com>
 <20160920100716.131d3647@gandalf.local.home>
 <0e38f79fdc1f4671943da74764c15050@SIWEX5A.sing.micron.com>
 <20160921171307.3fb84c87@xhacker>
 <20160921141705.6ab0be03@gandalf.local.home>
Message-ID: <baf9aa64cc5e479ca21e30c176062f20@SIWEX5A.sing.micron.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Steven Rostedt [mailto:rostedt at goodmis.org]
> Sent: Mittwoch, 21. September 2016 20:17
> To: Jisheng Zhang <jszhang@marvell.com>
> Cc: Bean Huo (beanhuo) <beanhuo@micron.com>; Zoltan Szubbocsev
> (zszubbocsev) <zszubbocsev@micron.com>; catalin.marinas at arm.com;
> will.deacon at arm.com; rfi at lists.rocketboards.org; linux-
> kernel at vger.kernel.org; mingo at redhat.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: ftrace function_graph causes system crash
> 
> On Wed, 21 Sep 2016 17:13:07 +0800
> Jisheng Zhang <jszhang@marvell.com> wrote:
> 
> > I'm not sure whether the commit d6df3576e6b4
> ("clocksource/drivers/arm_global_timer
> > : Prevent ftrace recursion") can fix this issue.
> >
> > this commit is merged since v4.3, I noticed your kernel version is v4.0
> 
> BTW, yes, that would be the fix.
> 
> -- Steve
> 
> >
> > Thanks,
> > Jisheng
> >
> > > Do you know now how to deeply debug and trace which line is wrong
> through Ftrace?
> > >

Hi, Steven and Jisheng
Thanks to both warm-hearted guys. I merged  d6df3576e6b4 patch into my kernel 4.0.
Then it is true, no cash appears again.

I have one more question that current ftrace can trace DMA latency, include mapping and unmapping?
Means I want to know when one BIO request be completed. Just like blktrace.
But blktrace can not tell me the function calling sequence.

--Bean 
