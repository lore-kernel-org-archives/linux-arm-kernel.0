From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 4 Apr 2016 17:22:54 +0200
Subject: [PATCH v5 32/46] pwm: deprecate pwm_config(), pwm_enable() and
 pwm_disable()
In-Reply-To: <20160331205454.630734ab@bbrezillon>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-33-git-send-email-boris.brezillon@free-electrons.com>
 <20160331173858.GB39098@dtor-ws>
 <20160331205454.630734ab@bbrezillon>
Message-ID: <20160404152254.GB17856@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 08:54:54PM +0200, Boris Brezillon wrote:
> Hi Dmitry,
> 
> On Thu, 31 Mar 2016 10:38:58 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi Boris,
> > 
> > On Wed, Mar 30, 2016 at 10:03:55PM +0200, Boris Brezillon wrote:
> > > Prefix those function as deprecated to encourage all existing users to
> > > switch to pwm_apply_state().
> > 
> > Why not keep at least some of them as wrappers where we do not need to
> > chnage several parameters at once? It is much easier to have a driver
> > do:
> > 
> > 	error = pwm_enable(pwm);
> > 	if (error)
> > 		...
> > 
> > rather than declaring the state variable, fectch it, adjust and then
> > apply.
> 
> True. Actually deprecating the non-atomic API was not my primary goal.
> Thierry would you mind if we keep both APIs around?

I'm fine with keeping these around, though purely as shortcuts. If users
need to modify two parameters at once (e.g. duty cycle and enable) then
they should be converted to use the atomic API, otherwise there'd be
little point in introduce it.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160404/dba11320/attachment.sig>
