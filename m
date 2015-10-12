From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 12 Oct 2015 16:30:02 +0100
Subject: [PATCH v4 0/3] arm64: EFI stub isolation
In-Reply-To: <20151010224051.GK2723@codeblueprint.co.uk>
References: <1444330924-17830-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151010224051.GK2723@codeblueprint.co.uk>
Message-ID: <20151012153002.GC6320@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 10, 2015 at 11:40:51PM +0100, Matt Fleming wrote:
> On Thu, 08 Oct, at 08:02:01PM, Ard Biesheuvel wrote:
> > We need to ensure that the EFI stub only uses parts of the kernel proper
> > that are safe to use when the kernel virtual mapping is not active yet.
> > 
> > So move all C code dependencies to the libstub, which is built with all
> > instrumentation (gcov, kasan) disabled, and do a verification pass to
> > ensure that no absolute relocations are used.
> > 
> > On the arm64 side, annotate all the stub's dependencies as safe for PI
> > (position independent
> > 
> > @Matt: if you are OK with these, may we please have your ack on patches #1 and
> > #2 so that Catalin can pick up the series? Thanks.
> 
> I assumed you meant PATCH 1 and PATCH 3. If so, yeah, these look fine
> to be taken through Catalin's tree.

Thanks for the review. Patches queued for 4.4.

-- 
Catalin
