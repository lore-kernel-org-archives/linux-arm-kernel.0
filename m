From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Thu, 16 Feb 2012 11:14:25 +0100
Subject: [PATCH RFC 0/4] Scheduler idle notifiers and users
In-Reply-To: <1329363097.3772.46.camel@pasglop>
References: <20120208013959.GA24535@panacea>
 <1328670355.2482.68.camel@laptop> <20120208202314.GA28290@redhat.com>
 <1328736834.2903.33.camel@pasglop> <20120209075106.GB18387@elte.hu>
 <4F35DD3E.4020406@codeaurora.org> <20120211144530.GA497@elte.hu>
 <4F3AEC4E.9000303@codeaurora.org> <1329313085.2293.106.camel@twins>
 <20120215140245.GB27825@n2100.arm.linux.org.uk>
 <1329318063.2293.136.camel@twins> <1329363097.3772.46.camel@pasglop>
Message-ID: <1329387265.2293.195.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-02-16 at 14:31 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2012-02-15 at 16:01 +0100, Peter Zijlstra wrote:
> > 
> > Thing is, the scheduler doesn't care about completion, all it needs is
> > to be able to kick-start the thing atomically. So you really have to
> > wait for it or can you do an interrupt driven state machine?
> 
> Or the scheduler callback could schedule a wq to do the job ?

That'll end up being very ugly due to lock inversion etc. If we can get
out of this using self-IPIs I'd much prefer that.
