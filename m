From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Wed, 15 Feb 2012 14:38:04 +0100
Subject: [PATCH RFC 0/4] Scheduler idle notifiers and users
In-Reply-To: <20120211153324.GC31887@opensource.wolfsonmicro.com>
References: <20120208013959.GA24535@panacea>
 <1328670355.2482.68.camel@laptop> <20120208202314.GA28290@redhat.com>
 <1328736834.2903.33.camel@pasglop> <20120209075106.GB18387@elte.hu>
 <4F35DD3E.4020406@codeaurora.org> <20120211143951.GA24564@sirena.org.uk>
 <1328971983.11320.5.camel@laptop>
 <20120211153324.GC31887@opensource.wolfsonmicro.com>
Message-ID: <1329313084.2293.105.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-02-11 at 15:33 +0000, Mark Brown wrote:
> > Having to actually wait for this in software is quite ridiculous.
> 
> Well, it's also not terribly hard. 

Having to schedule from the scheduler is. Which is exactly the situation
you'll end up with if you want scheduler driven cpufreq, which I thought
everybody wanted because polling state sucks.

>  There's use cases for having this
> stuff offloaded but if you're not doing that stuff then why deal with
> the complication of designing the hardware? 

Because doing it in software is more expensive?

Penny-wise pound-foolish like thing.. you make the software requirements
more complex, which results in more bugs (more cost in debugging), more
runtime (for doing the 'software' thing), less power savings.

Esp since all this uC/system-controller stuff is already available and
validated.
