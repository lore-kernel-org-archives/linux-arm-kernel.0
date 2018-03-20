From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Mar 2018 10:04:38 +0000
Subject: [PATCH v2 2/3] arm64: fpsimd: Fix bad si_code for undiagnosed
 SIGFPE
In-Reply-To: <87vadxyrdt.fsf@xmission.com>
References: <1519926248-12591-1-git-send-email-Dave.Martin@arm.com>
 <1519926248-12591-3-git-send-email-Dave.Martin@arm.com>
 <20180308171153.GD14918@arm.com> <87o9jymbsj.fsf@xmission.com>
 <20180309131017.GB20370@arm.com>
 <20180309142557.GT32331@e103592.cambridge.arm.com>
 <87vadxyrdt.fsf@xmission.com>
Message-ID: <20180320100437.GB24986@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 04:13:02PM -0500, Eric W. Biederman wrote:
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > On Fri, Mar 09, 2018 at 01:10:18PM +0000, Will Deacon wrote:
> >> Hi Eric,
> >> 
> >> On Thu, Mar 08, 2018 at 04:40:12PM -0600, Eric W. Biederman wrote:
> >> > Will Deacon <will.deacon@arm.com> writes:
> >> > > Happy to take this patch once the dependency on FPE_FLTUNK in core code is
> >> > > resolved.
> >> > 
> >> > Would it help for me to take the FPE_FLTUNK patch into my siginfo-next
> >> > branch?   So that there is a common branch with the code so we don't
> >> > need to worry about conflicts.  If so I will look at that on Monday.
> >> 
> >> Yes please, that would be helpful actually. I can then pull that into
> >> arm64 if you give me a stable branch or tag. Alternatively, I can define
> >> FPE_FLTUNK locally and remove it at -rc1.
> >
> > OK Eric, let me know if you need me to rebase anything for the first 2
> > patches.
> 
> The first patch is now in my siginfo-next tree and avialable at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-next
> HEAD: 266da65e9156d93e1126e185259a4aae68188d0e signal: Add FPE_FLTUNK si_code for undiagnosable fp exceptions
> 
> I will not rebase this branch, so please fee free to merge it into other
> trees.

Thanks, Eric. I've pulled this into the arm64 for-next/core branch and I'll
push it out later on.

Will
