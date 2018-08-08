From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 8 Aug 2018 09:30:44 +0100
Subject: [RFC PATCH 16/16] KVM: arm64/sve: Report and enable SVE API
 extensions for userspace
In-Reply-To: <20180807200828.GJ5985@e113682-lin.lund.arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-17-git-send-email-Dave.Martin@arm.com>
 <20180719145921.oasa3a57at5nnwya@kamzik.brq.redhat.com>
 <20180725152749.GQ4240@e103592.cambridge.arm.com>
 <20180725165256.k2kcrazgyt7y4i4o@kamzik.brq.redhat.com>
 <20180726131802.GX4240@e103592.cambridge.arm.com>
 <20180806134133.GE5985@e113682-lin.lund.arm.com>
 <20180807112345.GG9097@e103592.cambridge.arm.com>
 <20180807200828.GJ5985@e113682-lin.lund.arm.com>
Message-ID: <20180808083043.GJ9097@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2018 at 10:08:28PM +0200, Christoffer Dall wrote:
> On Tue, Aug 07, 2018 at 12:23:45PM +0100, Dave Martin wrote:
> > On Mon, Aug 06, 2018 at 03:41:33PM +0200, Christoffer Dall wrote:

[...]

> > > I'm personally fine with both feature flags and vcpu device ioctls.  If
> > > using vcpu device ioctls gives you an obvious way to set attributes
> > > relating to SVE, e.g. the vector length, then I think that's a strong
> > > argument for that approach.
> > 
> > There is another option I'm tending towards, which is simply to have
> > a "set vector lengths" ioctl (whether presented as a vcpu device
> > ioctl or a random arch ioctl).
> 
> Someone complained once about adding too many arch ioctls because there
> is a limited number space for doing so, but I'm not sure if that was and
> still a valid concern.

I have no strong opinion on this.  I may stick with the separate ioctl
approach for the next spin just to reduce the amount of churn, but I'm
not overly committed to it.

> > 
> > If that ioctl() fails then SVE support is not available.
> > 
> > If it succeeds, it will update its arguments to indicate which
> > vector lengths are enabled (if different).
> > 
> > Old userspace, or userspace that doesn't want to use SVE, would
> > not use this ioctl at all.
> > 
> > It would also do no harm additionally to advertise this as a
> > capability, though I wonder whether it's necessary to do so (?)
> > 
> 
> It is customary to expose features via capabilities.  I have a vague
> recollection that tools like libvirt negotiate capabilities across
> systems and would need more plumbing to discover features by probing an
> ioctl instead.

OK, fair enough.

Cheers
---Dave
