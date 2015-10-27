From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Tue, 27 Oct 2015 21:07:35 +0000
Subject: [PATCH] arm64/efi: move arm64 specific stub C code to libstub
In-Reply-To: <CAKv+Gu-2-=b-+X8xRpVFO5oFE2_0Eho2-H6VWYWWqonOdaKL5w@mail.gmail.com>
References: <1445611694-31838-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151026211133.GB3526@codeblueprint.co.uk>
 <CAKv+Gu-2-=b-+X8xRpVFO5oFE2_0Eho2-H6VWYWWqonOdaKL5w@mail.gmail.com>
Message-ID: <20151027210735.GA8973@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Oct, at 11:10:43AM, Ard Biesheuvel wrote:
> On 27 October 2015 at 06:11, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> > On Fri, 23 Oct, at 04:48:14PM, Ard Biesheuvel wrote:
> >> Now that we added special handling to the C files in libstub, move
> >> the one remaining arm64 specific EFI stub C file to libstub as
> >> well, so that it gets the same treatment. This should prevent future
> >> changes from resulting in binaries that may execute incorrectly in
> >> UEFI context.
> >
> > Sorry, I'm coming at this cache-cold: What special handling was added
> > to libstub that you want to make use of here?
> >
> 
> This is about the libstub patches that you reviewed ~2 weeks ago and
> that have been queued in Catalin's arm64 tree for 4.4
> 
> >> With efi-entry.S the only remaining EFI stub source file under
> >> arch/arm64, we can also simplify the Makefile logic somewhat.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>
> >> I would like to suggest that this be taken on top of the stuff that is
> >> queued for 4.4 at the moment (if it is not too late already).
> >
> > That's upto the tip folks (Cc'd). Ingo, would you consider applying
> > a minimal build cleanup patch like this for v4.4?
> >
> 
> Actually, the suggestion was aimed at Catalin, who has all the libstub
> and KASAN patches queued that this patch depends on.
> Apologies for the confusion.

Fair enough. In that case (for the drivers/firmware bits),

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
