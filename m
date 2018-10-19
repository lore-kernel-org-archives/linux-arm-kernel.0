From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 19 Oct 2018 15:23:31 +0200
Subject: [GIT PULL 00/26] KVM/arm updates for 4.20
In-Reply-To: <20181019125901.185478-1-marc.zyngier@arm.com>
References: <20181019125901.185478-1-marc.zyngier@arm.com>
Message-ID: <9af51d24-fe4a-32d9-3637-004ce9ed0e7d@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/10/2018 14:58, Marc Zyngier wrote:
> Paolo, Radim,
> 
> This is the bulk of the KVM/arm changes for 4.20. This time, the
> biggest change by far is the support for variable addressing range in
> guests, allowing userspace to size arm64 VMs from 32 to 52bits instead
> of the hard-coded 40bits we've enjoyed so far. Other than that, we
> have a random selection of small fixes and cleanups.
> 
> Note that this will generate a few minor conflicts with the arm64 tree,
> which should be resolved as per this branch[1].

That's a bit annoying.  KVM parts of "Support Common Not Private
translations" should not have gone through the arm64 tree.  Instead,
Catalin should have placed the first patches in a topic branch for you
to pull.

This minimizes the effort for everyone else, basically.  Conflicts need
to be sorted out by Stephen Rothwell, myself and Linus/Greg, while topic
branches just work.

If it weren't for the include/uapi/linux/kvm.h change, where I have to
sort the capability numbers as they are assigned by the various
architecture maintainers(*), I would have told you to just send the pull
request to Catalin this time through (but that would just be a band-aid,
it should not be the norm).  Anyway, just remember this next time.

Thanks,

Paolo

	(*) That's also a bit suboptimal, because it complicates
	    debugging of new features after they're merged, but I have
	    no better idea.
