From: philippe.retornaz@epfl.ch (Philippe =?ISO-8859-1?Q?R=E9tornaz?=)
Date: Sat, 31 Dec 2011 00:31:55 +0100
Subject: ftrace performance impact with different configuration
In-Reply-To: <1325283941.24045.15.camel@gandalf.stny.rr.com>
References: <CALZhoSRVNp=Sj2u2GHiQhuHOEdrfiM58KzG+RutvJV=8CoCpTQ@mail.gmail.com>
 <23257775.9kkYY4quUh@laptop> <1325283941.24045.15.camel@gandalf.stny.rr.com>
Message-ID: <2631878.q7bjHk7YBM@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 30 d?cembre 2011 17:25:41 Steven Rostedt a ?crit :
> On Fri, 2011-12-30 at 14:07 +0100, Philippe R?tornaz wrote:
> > Sorry about being a bit naive, but why it is not possible to do it in
> > two
> > steps ?
> > call stop_machine to put the jmp which skip the call to mcount
> > Then wait until all tasks hits schedule() (synchronize_sched() ?)
> (...)
> There's no way to safely modify two instructions that depend on each
> other in a preemptible kernel, with the exception of waiting for all
> CPUs to hit idle (which may never happen on a busy system). And even
> that may be racy.
> 

Thanks for the detailed explanation, I got it now. I guess the only way would 
be to use the freezer api like freeze_processes() is doing. Looks like it does 
not worth the pain.

Thanks ! 

Philippe
