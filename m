From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 21 Jan 2015 08:06:12 -0500
Subject: [PATCH 3.19-rc2 v14 0/7] arm: Implement
 arch_trigger_all_cpu_backtrace
In-Reply-To: <54BF83C9.5060300@linaro.org>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1421144818-14036-1-git-send-email-daniel.thompson@linaro.org>
 <54BE2D15.9080606@linaro.org> <54BEC04D.1050402@codeaurora.org>
 <54BF83C9.5060300@linaro.org>
Message-ID: <20150121080612.6569ab81@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Jan 2015 10:47:37 +0000
Daniel Thompson <daniel.thompson@linaro.org> wrote:


> > With this patchset, is it possible to call sched_clock() from within NMI
> > context? I ask because the generic sched_clock() code is not NMI safe

That's not good. Better not run function tracing, as that could trace
functions in NMI context (I depend on that it does), and it uses
sched_clock() as the default clock.

-- Steve


> > today. We were planning on making it NMI safe by doing something similar
> > to what was done for ktime_get_mono_fast_ns() but we haven't gotten
> > around to it. Mostly because no architecture that uses generic
> > sched_clock() has support for NMIs right now.
> 
