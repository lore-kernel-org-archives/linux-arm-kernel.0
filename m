From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 15 Oct 2013 19:33:46 -0400
Subject: [PATCH] ARM: trace: Add tracepoint for the Inter Processor
 Interrupt
In-Reply-To: <525CE007.6070101@linaro.org>
References: <1381758807-31139-1-git-send-email-daniel.lezcano@linaro.org>
 <20131014232004.5cbedbb8@gandalf.local.home>
 <525CE007.6070101@linaro.org>
Message-ID: <20131015193346.292b252d@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Oct 2013 08:26:15 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:


> Mmh, I have a doubt here about the trace. I can remove the cpumask 
> because it is not used but in the other hand, it would be interesting to 
> have in the trace the cpumask of the recipient cpus for the IPI. 
> Unfortunately, I don't know how to convert this cpumask to a string 
> without using the cpumask_scnprintf which imply a more complex print trace.
> 
> Do you have some advices for that ?

What's wrong with recording the cpumask into the trace buffer and then
using cpumask_scnprintf() as output? We can update trace-cmd and
libtraceevent to handle that output too.

-- Steve
