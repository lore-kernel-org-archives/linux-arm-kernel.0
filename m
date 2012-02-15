From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 15 Feb 2012 08:04:38 -0800
Subject: [PATCH RFC 0/4] Scheduler idle notifiers and users
In-Reply-To: <1329313084.2293.105.camel@twins>
References: <20120208013959.GA24535@panacea> <1328670355.2482.68.camel@laptop>
 <20120208202314.GA28290@redhat.com>
 <1328736834.2903.33.camel@pasglop> <20120209075106.GB18387@elte.hu>
 <4F35DD3E.4020406@codeaurora.org>
 <20120211143951.GA24564@sirena.org.uk>
 <1328971983.11320.5.camel@laptop>
 <20120211153324.GC31887@opensource.wolfsonmicro.com>
 <1329313084.2293.105.camel@twins>
Message-ID: <20120215160437.GD2996@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 02:38:04PM +0100, Peter Zijlstra wrote:
> On Sat, 2012-02-11 at 15:33 +0000, Mark Brown wrote:

> >  There's use cases for having this
> > stuff offloaded but if you're not doing that stuff then why deal with
> > the complication of designing the hardware? 

> Because doing it in software is more expensive?

> Penny-wise pound-foolish like thing.. you make the software requirements
> more complex, which results in more bugs (more cost in debugging), more
> runtime (for doing the 'software' thing), less power savings.

> Esp since all this uC/system-controller stuff is already available and
> validated.

It's really not - like I say most of the times people have tried to
deploy this on embedded systems it's just made everyone more miserable
and typically winds up getting turned off or bypassed.  The PMICs are
much more decoupled from the CPUs and the power control on the SoCs is
more fine grained than you seem to see in the desktop market.  There's
software effort but people are willing to spend that for microamps and
all other things being equal they'd typically rather spend it in the
software stack they're already working with rather than in a separate
stack for a microcontroller.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120215/8aec5865/attachment-0001.sig>
