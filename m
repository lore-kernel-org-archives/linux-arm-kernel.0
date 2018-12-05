Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3D8C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:22:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5068620645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="btGXZoaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5068620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AS/SKnRL+PSHu7K9VNTk1U0at2TFpHksZMWqWyu7tcg=; b=btGXZoazcw5Wzn
	BZ3Bh0MAnf+KU2pGFcduHrM2uXygUmHBPR/pb7P0WQPTVYb6VEKqtmvwJMxo/jeSxGTFXNlfa1wjY
	vfxAxhlWZWiSaXfZcKofaH0yJlxHg6PKUdWO6Uw684td/5gffX44scRvQEjresM0pQcaOR2QMe2xA
	RlPHNBl/oqXs9cDeCz30ecr3sAeCMHJS+HAHkZhNCRVp287xDyBuICTW6uBLLtbO7StiC7yHd4t4N
	6HAmZUQE4V6GhMNchfs0kUMMxOlJfUblwUBgi6uum4RDcxCKbre5s5TGS8GFwnR/afrR0lcJSRbT8
	bTGqRlurP+2OJzInNdrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUboh-0006RU-3d; Wed, 05 Dec 2018 18:22:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUboa-0006A5-MM
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:22:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F6A280D;
 Wed,  5 Dec 2018 10:22:18 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 859893F575;
 Wed,  5 Dec 2018 10:22:16 -0800 (PST)
Date: Wed, 5 Dec 2018 18:22:14 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH v2 19/23] KVM: arm64/sve: Report and enable SVE API
 extensions for userspace
Message-ID: <20181205182210.GU3505@e103592.cambridge.arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-20-git-send-email-Dave.Martin@arm.com>
 <87a7m1i1b2.fsf@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a7m1i1b2.fsf@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_102229_192550_41F70AA9 
X-CRM114-Status: GOOD (  45.85  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 22, 2018 at 03:23:13PM +0000, Alex Benn=E9e wrote:
> =

> Dave Martin <Dave.Martin@arm.com> writes:
> =

> > This patch adds the necessary API extensions to allow userspace to
> > detect SVE support for guests and enable it.
> >
> > A new capability KVM_CAP_ARM_SVE is defined to allow userspace to
> > detect the availability of the KVM SVE API extensions in the usual
> > way.
> >
> > Userspace needs to enable SVE explicitly per vcpu and configure the
> > set of SVE vector lengths available to the guest before the vcpu is
> > allowed to run.  For these purposes, a new arm64-specific vcpu
> > ioctl KVM_ARM_SVE_CONFIG is added, with the following subcommands
> > (in rough order of expected use):
> >
> > KVM_ARM_SVE_CONFIG_QUERY: report the set of vector lengths
> >     supported by this host.
> >
> >     The resulting set can be supplied directly to
> >     KVM_ARM_SVE_CONFIG_SET in order to obtain the maximal possible
> >     set, or used to inform userspace's decision on the appropriate
> >     set of vector lengths (possibly taking into account the
> >     configuration of other nodes in the cluster so that the VM can
> >     migrate freely).
> >
> > KVM_ARM_SVE_CONFIG_SET: enable SVE for this vcpu and configure the
> >     set of vector lengths it offers to the guest.
> >
> >     This can only be done once, before the vcpu is run.
> >
> > KVM_ARM_SVE_CONFIG_GET: report the set of vector lengths available
> >     to the guest on this vcpu (for use when snapshotting or
> >     migrating a VM).
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >
> > Changes since RFCv1:
> >
> >  * The new feature bit for PREFERRED_TARGET / VCPU_INIT is gone in
> >    favour of a capability and a new ioctl to enable/configure SVE.
> >
> >    Perhaps the SVE configuration could be done via device attributes,
> >    but it still has to be done early, so crowbarring support for this
> >    behind a generic API may cause more trouble than it solves.
> >
> >    This is still up for discussion if anybody feels strongly about it.
> >
> >  * An ioctl KVM_ARM_SVE_CONFIG has been added to report the set of
> >    vector lengths available and configure SVE for a vcpu.
> >
> >    To reduce ioctl namespace pollution the new operations are grouped
> >    as subcommands under a single ioctl, since they use the same
> >    argument format anyway.
> > ---
> >  arch/arm64/include/asm/kvm_host.h |   8 +-
> >  arch/arm64/include/uapi/asm/kvm.h |  14 ++++
> >  arch/arm64/kvm/guest.c            | 164 ++++++++++++++++++++++++++++++=
+++++++-
> >  arch/arm64/kvm/reset.c            |  50 ++++++++++++
> >  include/uapi/linux/kvm.h          |   4 +
> >  5 files changed, 238 insertions(+), 2 deletions(-)
> >

[...]

> > diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> > index e37c78b..c2edcde 100644
> > --- a/arch/arm64/kvm/reset.c
> > +++ b/arch/arm64/kvm/reset.c
> > @@ -19,10 +19,12 @@
> >   * along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
> >   */
> >
> > +#include <linux/atomic.h>
> >  #include <linux/errno.h>
> >  #include <linux/kvm_host.h>
> >  #include <linux/kvm.h>
> >  #include <linux/hw_breakpoint.h>
> > +#include <linux/string.h>
> >
> >  #include <kvm/arm_arch_timer.h>
> >
> > @@ -54,6 +56,31 @@ static bool cpu_has_32bit_el1(void)
> >  	return !!(pfr0 & 0x20);
> >  }
> >
> > +#ifdef CONFIG_ARM64_SVE
> > +bool kvm_sve_supported(void)
> > +{
> > +	static bool warn_printed =3D false;
> > +
> > +	if (!system_supports_sve())
> > +		return false;
> > +
> > +	/*
> > +	 * For now, consider the hardware broken if implementation
> > +	 * differences between CPUs in the system result in the set of
> > +	 * vector lengths safely virtualisable for guests being less
> > +	 * than the set provided to userspace:
> > +	 */
> > +	if (sve_max_virtualisable_vl !=3D sve_max_vl) {
> > +		if (!xchg(&warn_printed, true))
> > +			kvm_err("Hardware SVE implementations
> > mismatched: suppressing SVE for guests.");
> =

> This seems like you are re-inventing WARN_ONCE for the sake of having
> "kvm [%i]: " in your printk string.

Yes... adding a kvm_err_once() just for this seemed overkill.

Perhaps we don't really need to print the PID here anyway: this is a
system issue, not something that specific KVM instance did wrong, so
it's misleading to confine the warning to a specific PID.

So maybe I should just do a bare printk_once(KERN_ERR "kvm: " ...)
instead?

> =

> > +
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +#endif
> > +
> >  /**
> >   * kvm_arch_dev_ioctl_check_extension
> >   *
> > @@ -85,6 +112,9 @@ int kvm_arch_dev_ioctl_check_extension(struct kvm *k=
vm, long ext)
> >  	case KVM_CAP_VCPU_EVENTS:
> >  		r =3D 1;
> >  		break;
> > +	case KVM_CAP_ARM_SVE:
> > +		r =3D kvm_sve_supported();
> > +		break;
> =

> For debugging we actually use the return value to indicate how many
> WP/BPs we have. We could do the same here for max number of VQs but I
> guess KVM_ARM_SVE_CONFIG_QUERY reports a much richer set of information.
> However this does beg the question of how useful all this extra
> information is to the guest program?

As elaborated below, while I agree that the max VQ is potentially useful
to return here, I don't think it's enough.  There's a risk people will
get lazy and just guess which VQs <=3D the max are supported from the
return here.

So I prefer to return nothing, to avoid giving a false comfort to the
caller.

> =

> A dumber implementation would be:
> =

> QEMU                 |        Kernel
> =

> KVM_CAP_ARM_SVE  --------->
>                               Max VQ=3Dn
>            VQ/0  <---------
> =

> We want n < max VQ
> =

> KVM_ARM_SVE_CONFIG(n) ---->
>                               Unsupported VQ
>            EINVAL <--------
> =

> Weird HW can't support our choice of n.
> Give up or try another value.
> =

> KVM_ARM_SVE_CONFIG(n-1) --->
>                               That's OK
>            0 (OK) <---------
> =

> It imposes more heavy lifting on the userspace side of things but I
> would expect the "normal" case would be sane hardware supports all VLs
> from Max VQ to 1. And for cases where it doesn't iterating through
> several KVM_ARM_SVE_CONFIG steps is a start-up cost not a runtime one.

The architecture only mandates power-of-two vector lengths, and I would
not be surprised to see hardware that takes advantage of that.

> This would mean one capability and one SVE_CONFIG sub-command with a sing=
le
> parameter. Would could always add the extend the interface later but I
> wonder if we are gold plating the API too early here?

I agree this is simpler and would typically work, but I'm not confident
that max VQ is sufficient alone to avoid silently letting
incompatibilities through.

That's why I designed the interface to specify the set of VQs explicitly
rather than just specifying the maximum and accepting whatever other VQs
come along with it.

The problem is that if you created a VM on a node that only supports
power-of-two vector lengths (say), and then migrate to a node that
support the same or greater max VQ but supports additional
non-power-of-two vector lengths below that, then weird things are going
to happen in the guest -- yet we would silently allow that here.

Of course, we could throw this into the "you are supposed to know what
you are doing and build a sane compute cluster" bucket, but I'd prefer
to be able to flag up obvious incompatibilities explicitly.

> What do the maintainers thing?
> =

> =

> >  	default:
> >  		r =3D 0;
> >  	}
> > @@ -92,6 +122,21 @@ int kvm_arch_dev_ioctl_check_extension(struct kvm *=
kvm, long ext)
> >  	return r;
> >  }
> >
> > +int kvm_reset_sve(struct kvm_vcpu *vcpu)
> > +{
> > +	if (!vcpu_has_sve(vcpu))
> > +		return 0;
> > +
> > +	if (WARN_ON(!vcpu->arch.sve_state ||
> > +		    !sve_vl_valid(vcpu->arch.sve_max_vl)))
> > +		return -EIO;
> =

> For some reason using WARN_ON for side effects seems sketchy but while
> BUG_ON can compile away to nothing it seems WARN_ON has been designed to
> always give you a result of the condition so never mind...

I think this is a common idiom in the kernel.

I would definitely agree that WARN_ON(expr) (and especially
BUG_ON(expr)) is poor practice if expr has side-effects, but as you say,
WARN_ON() seems to have been designed explicitly to let the check
expression show through.

If nothing else, this avoids the possibility of typoing the expression
between the WARN_ON() and the accompanying if ().

That's just my opinion, but I'll probably stick with it in its current
form unless somebody shouts.

Cheers
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
