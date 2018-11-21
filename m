From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Wed, 21 Nov 2018 13:07:57 +0530
Subject: [PATCH v2] x86_64,
 vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03560F84@BPXM09GP.gisp.nec.co.jp>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03560F84@BPXM09GP.gisp.nec.co.jp>
Message-ID: <CACi5LpPestnsByi29X9uOaP04J3LgG4BSj_ODKEDG8S9sLkEsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kazu,

On Tue, Nov 20, 2018 at 2:47 AM Kazuhito Hagio <k-hagio@ab.jp.nec.com> wrote:
>
> On 11/15/2018 4:47 PM, Bhupesh Sharma wrote:
> > Adding 'page_offset_base' to the vmcoreinfo can be specially useful for
> > live-debugging of a running kernel via user-space utilities
> > like makedumpfile (see [1]).
>
> I agree.
>
> > Recently, I saw an issue with the 'makedumpfile' utility (see [2] for
> > details), whose live debugging feature is broken with newer kernels
> > (I tested the same with 4.19-rc8+ kernel), as KCORE_REMAP segments were
> > added to kcore, thus leading to an additional sections in the same, and
> > makedumpfile is not longer able to determine the start of direct
> > mapping of all physical memory, as it relies on traversing the PT_LOAD
> > segments inside kcore and using the last PT_LOAD segment
> > to determine the start of direct mapping.
>
> Actually, the KCORE_REMAP segments were already removed from kcore by
> commit bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")
> and kcore's program headers got back to the previous ones, but this
> fact shows that they are changeable.
>
> So I think that if we have this NUMBER(page_offset_base) in vmcoreinfo
> for x86_64, user-space tools (especially makedumpfile) would become
> more stable against changes in kcore and vmcore, rather than depending
> on their PT_LOAD values.

Thanks a lot for your review.

Hi x86 maintainers,

Ping, any comments on this patch. Since it is a useful addition to the
kernel-userspace ABI (as suggested by the user-space utility
maintainer as well), can we consider including this in the kernel?

Thanks,
Bhupesh
