From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 Jul 2018 10:26:29 +0100
Subject: [PATCH v2] arm64, kaslr: export offset in VMCOREINFO ELF notes
In-Reply-To: <303e32f7-ff47-ea9b-d5a0-45a22e44d0a9@arm.com>
References: <1532931883-16132-1-git-send-email-bhsharma@redhat.com>
 <303e32f7-ff47-ea9b-d5a0-45a22e44d0a9@arm.com>
Message-ID: <20180731092629.GD4680@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 10:19:35AM +0100, James Morse wrote:
> Hi Bhupesh,
> 
> On 30/07/18 07:24, Bhupesh Sharma wrote:
> > Include KASLR offset in arm64 VMCOREINFO ELF notes to assist in
> > debugging. vmcore parsing in user-space already expects this value in
> > the notes and we are providing it for portability of those existing
> > tools with x86.
> > 
> > Ideally we would like core code to do this (so that way this
> > information won't be missed when an architecture adds KASLR support),
> > but mips has CONFIG_RANDOMIZE_BASE, and doesn't provide kaslr_offset(),
> > so I am not sure if this is needed for mips (and other such similar arch
> > cases in future). So, lets keep this architecture specific for now.
> 
> (heh, I assumed you would rewrite my train-of-thought, but I guess this works!)
> 
> 
> > As an example of a user-space use-case, consider the
> > makedumpfile user-space utility which will need fixup to use this
> > KASLR offset to work with cases where we need to find a way to
> > translate symbol address from vmlinux to kernel run time address
> > in case of KASLR boot on arm64.
> 
> Acked-by: James Morse <james.morse@arm.com>
> 
> If we want to send this to stable, it looks like it should have been part of the
> KASLR series, f80fb3a3d5084 ("arm64: add support for kernel ASLR") was merged
> for v4.6.
> CC: <stable@vger.kernel.org> # 4.6.x

Hmm, does this warrant a stable backport? This hasn't ever worked, right?

Will
