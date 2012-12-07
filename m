From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 07 Dec 2012 13:17:25 -0500
Subject: [PATCH] ARM: ftrace: Ensure code modifications are synchronised
 across all cpus
In-Reply-To: <1354903568.17101.65.camel@gandalf.local.home>
References: <1354817466.30905.13.camel@linaro1.home>
 <1354821581.17101.17.camel@gandalf.local.home>
 <1354872138.3176.15.camel@computer5.home>
 <1354888985.17101.41.camel@gandalf.local.home>
 <1354892111.13000.50.camel@linaro1.home>
 <1354894134.17101.44.camel@gandalf.local.home>
 <20121207162346.GW14363@n2100.arm.linux.org.uk>
 <1354898200.17101.50.camel@gandalf.local.home>
 <20121207164530.GX14363@n2100.arm.linux.org.uk>
 <1354900436.17101.58.camel@gandalf.local.home>
 <1354902347.8263.12.camel@linaro1.home>
 <1354903568.17101.65.camel@gandalf.local.home>
Message-ID: <1354904245.17101.66.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-12-07 at 13:06 -0500, Steven Rostedt wrote:

> If you can get away with that, sure. Or better yet. If the arch supports
> it, you can do what I did with powerpc. That was just replace the nop
> with the 32bit branch, and the 32bit branch with a 32bit nop. No nops.

s/No nops/No breakpoints/

> No multiple steps in between. I just did the swap of all function
> tracepoints in one fell swoop, and then did the icache sync.
> 

-- Steve
