From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 7 Nov 2014 22:07:17 +0100
Subject: [PATCH v13 3/7] KVM: x86: flush TLBs last before returning from
 KVM_GET_DIRTY_LOG
In-Reply-To: <545D2F1D.8040106@samsung.com>
References: <1415320848-13813-1-git-send-email-m.smarduch@samsung.com>
 <1415320848-13813-4-git-send-email-m.smarduch@samsung.com>
 <545C7845.9010103@redhat.com> <545D2271.4090906@samsung.com>
 <20141107200215.GA23953@cbox> <545D2F1D.8040106@samsung.com>
Message-ID: <20141107210717.GL22848@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 12:44:13PM -0800, Mario Smarduch wrote:
> On 11/07/2014 12:02 PM, Christoffer Dall wrote:
> > On Fri, Nov 07, 2014 at 11:50:09AM -0800, Mario Smarduch wrote:
> >> On 11/06/2014 11:44 PM, Paolo Bonzini wrote:
> >>>
> >>>
> >>> On 07/11/2014 01:40, Mario Smarduch wrote:
> >>>> In the next patches, we will move parts of x86's kvm_vm_ioctl_get_dirty_log
> >>>> implementation to generic code; leave the arch-specific code at the end,
> >>>> similar to the existing generic function kvm_get_dirty_log.
> >>>>
> >>>> Reviewed-by: Mario Smarduch <m.smarduch@samsung.com>
> >>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>>
> >>> You should have a "Signed-off-by: Mario Smarduch ..." here, and you 
> >>> should also add my authorship.  You can do the latter with "git rebase 
> >>> -i", adding
> >>>
> >>>   x git commit --amend -C HEAD --author 'Paolo Bonzini <pbonzini@redhat.com>'
> >>>
> >>> after this patch.  If you're using a patch queue instead (quilt or
> >>> similar) you can just edit the "From" line in the patch.
> >>>
> >>> I guess if you reply to the patch with just
> >>>
> >>>    Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> >>>
> >>> the ARM maintainers can do the above for you, if there's no need for
> >>> a v14.
> >>>
> >>> I'll send an eighth patch to actually switch x86 to the new function.
> >>> Again, the maintainers can apply it in the right place, but please
> >>> include it yourself if you have to do a v14.
> >>>
> >>> Thanks,
> >>>
> >>> Paolo
> >>
> >> I kind of thought something was wrong :) Thanks for the explanation,
> >> until I get the hang of it I'll defer to ARM maintainers. Maybe later
> >> update SubmittingPatches documentation.
> >>
> > Since you're doing a respin (right?) then please get the authorship
> > and signed-off-by's right for the next iteration.
> 
> Yes
> > 
> > If you're having trouble with the git mangling to get it right, don't be
> > afraid to reach out, here or on IRC.
> 
> Yes definitely need some coaching on this, this is not git 101 anymore.
> 
It's not that complicated; just get all the patches applied and use 'git
rebase -i', mark Paolo's commit as edit, when it stops at that commit
do:

 # git commit -s --amend -C HEAD --author 'Paolo Bonzini <pbonzini@redhat.com>'
 # git rebase --continue

and the '-s' to the commit should add your signed-off-by automatically.

-Christoffer
