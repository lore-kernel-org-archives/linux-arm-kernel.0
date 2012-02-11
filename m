From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 11 Feb 2012 15:33:25 +0000
Subject: [PATCH RFC 0/4] Scheduler idle notifiers and users
In-Reply-To: <1328971983.11320.5.camel@laptop>
References: <20120208013959.GA24535@panacea> <1328670355.2482.68.camel@laptop>
 <20120208202314.GA28290@redhat.com>
 <1328736834.2903.33.camel@pasglop> <20120209075106.GB18387@elte.hu>
 <4F35DD3E.4020406@codeaurora.org>
 <20120211143951.GA24564@sirena.org.uk>
 <1328971983.11320.5.camel@laptop>
Message-ID: <20120211153324.GC31887@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 11, 2012 at 03:53:03PM +0100, Peter Zijlstra wrote:
> On Sat, 2012-02-11 at 14:39 +0000, Mark Brown wrote:

> > For step downs this isn't such a big deal as we don't often care if the
> > voltage drops immediately but for step ups it's critical as if the
> > voltage hasn't ramped before the CPU tries to run at the higher
> > frequency the CPU will brown out. 

> Why isn't all this done by micro-controllers, software writes a desired
> state in some machine register (fast), micro-controller sets about
> making it so in an asynchronous way. If it finds the settings have
> changed by the time it reached its former goal, goto 1.

*Something* is going to have to wait for all the steps to take
place, if when frequency scaling you're not particlarly worried about
waiting for the the actual completion of your frequency change then
doing it in the CPU isn't that hard - you just post the request off
elsewhere and let it get on with trying implement whatever the last
request it saw was (along with all the other constraints it's seeing).
Modulo non-trivial implementation issues, of couse.

> Having to actually wait for this in software is quite ridiculous.

Well, it's also not terribly hard.  There's use cases for having this
stuff offloaded but if you're not doing that stuff then why deal with
the complication of designing the hardware?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120211/af6a8f44/attachment.sig>
