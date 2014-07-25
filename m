From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Jul 2014 10:21:09 +0100
Subject: [PATCH] arm64: audit: Fix build for audit changes
In-Reply-To: <20140724191237.GM17528@sirena.org.uk>
References: <1405596402-23844-1-git-send-email-broonie@kernel.org>
 <20140724191237.GM17528@sirena.org.uk>
Message-ID: <20140725092108.GB24268@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 08:12:37PM +0100, Mark Brown wrote:
> On Thu, Jul 17, 2014 at 12:26:42PM +0100, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>
> > 
> > Commit 3efe33f5d2 (audit: x86: drop arch from __audit_syscall_entry()
> > interface) removed the arch parameter from __audit_syscall_entry() and
> > updated the only current user in mainline but this breaks the ARMv8 audit
> > code that has been added in -next. Fix this by making the equivalent
> > update to ARMv8.
> 
> This is still broken -next.

It should now be temporarily fixed for the defconfig
(CONFIG_AUTIDSYSCALL disabled). I'm reluctant to merge the audit tree in
the arm64 tree as (a) I haven't seen a confirmation that this branch is
stable and will go upstream as is and (b) there are x86 changes without
Acks from the x86 maintainers (whether needed or not, I can't say).

So my temporary patch is some #ifndef's around the offending code. It
will be reverted and your patch applied once the audit tree meets the
arm64 tree.

-- 
Catalin
