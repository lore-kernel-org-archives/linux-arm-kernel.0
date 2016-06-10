From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 10 Jun 2016 18:47:46 +0200
Subject: [PATCH v2 01/13] pwm: Add new helpers to create/manipulate PWM
 states
In-Reply-To: <20160610182942.5e7485ff@bbrezillon>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465403688-17098-2-git-send-email-boris.brezillon@free-electrons.com>
 <20160610152109.GQ27142@ulmo.ba.sec>
 <20160610182942.5e7485ff@bbrezillon>
Message-ID: <20160610164746.GB8696@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2016 at 06:29:42PM +0200, Boris Brezillon wrote:
> On Fri, 10 Jun 2016 17:21:09 +0200, Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Wed, Jun 08, 2016 at 06:34:36PM +0200, Boris Brezillon wrote:
[...]
> > > + * according to your need before calling pwm_apply_state().  
> > 
> > Maybe mention that the ->duty_cycle field is explicitly zeroed. Then
> > again, do we really need it? If users are going to overwrite it anyway,
> > do we even need to bother? I suppose it makes some sense because the
> > current duty cycle is stale when the ->period gets set to the value from
> > args. I think the documentation should mention this in some way.
> 
> Yes, if we keep the current duty_cycle it can exceed the period value.
> I'm fine dropping the ->duty_cycle = 0 assignment and documenting the
> behavior.

Actually what I was trying to suggest is that we keep the code as-is but
document the behaviour (and rationale behind it).

I think it's fine to zero out the value precisely because it could
become invalid after the function (and there's no other reasonable value
to set it to). Just wanted to make sure it's all properly documented.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/8be32721/attachment.sig>
