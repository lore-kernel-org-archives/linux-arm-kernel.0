From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 May 2014 21:58:03 +0200
Subject: [PATCH v6 2/4] live migration support for initial write protect
 of VM
In-Reply-To: <1400178451-4984-3-git-send-email-m.smarduch@samsung.com>
References: <1400178451-4984-1-git-send-email-m.smarduch@samsung.com>
 <1400178451-4984-3-git-send-email-m.smarduch@samsung.com>
Message-ID: <20140527195803.GB16428@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 11:27:29AM -0700, Mario Smarduch wrote:
> Patch adds memslot support for initial write protection and split up of huge 
> pages

I lost track of where we are with these patches, but I see a lot of
issues in this patch that I believe I already commented on (but I may
not have had time to comment before you sent out v6).

In any case, I'm going to wait with reviewing things carefully until you
send out a v7, but for v7:
 - Please document the rationale and design behind what you're doing in
   the commit text of each patch.  Each of these patches are quite
   large, but the commit messages are barely two lines.  I suggest you
   take a look at 'git log arch/arm/kvm' for example to get a feel for
   what I'm looking for.

 - There is nothing specific in the interface to KVM discussing
   migration or live migration, it is only used as an example for
   features in trying to stay generic.  Please use similar generic
   concepts in the kernel to make things coherent.  'git grep
   migration arch/x86/kvm' also tells you that x86 gets away with full
   support for live migration without referring to migration except as
   examples of how features might be useful.

Thanks for the work, looking forward to seeing a new revision.

-Christoffer
