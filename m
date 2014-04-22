From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 22 Apr 2014 16:09:18 +0200
Subject: BUG: spinlock trylock failure on UP, i.MX28 3.12.15-rt25
In-Reply-To: <20140422094657.5b6ca1e2@gandalf.local.home>
References: <534C3606.7010206@meduna.org> <534C731F.1050406@meduna.org>
 <534DADF1.6060608@meduna.org>
 <20140422115439.GA20669@linutronix.de>
 <20140422094657.5b6ca1e2@gandalf.local.home>
Message-ID: <20140422140918.GE11096@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 09:46:57AM -0400, Steven Rostedt wrote:
> >  According to lockdep a trylock should not fail on UP.

Oh!? Where does it say that? A trylock can fail at all times.
