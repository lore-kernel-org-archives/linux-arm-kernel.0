From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Mar 2018 17:13:43 +0000
Subject: [PATCH] arm64/efi: Make strrchr() available to the EFI namespace
In-Reply-To: <CAKv+Gu8E=wg-=KCtsR=GFEwT1SsEaGFujBx8PNq0JkCAmJYktw@mail.gmail.com>
References: <20180301162803.5490-1-robh@kernel.org>
 <20180301170826.GA2678@arm.com>
 <CAKv+Gu8E=wg-=KCtsR=GFEwT1SsEaGFujBx8PNq0JkCAmJYktw@mail.gmail.com>
Message-ID: <20180301171343.GB2678@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 05:10:38PM +0000, Ard Biesheuvel wrote:
> On 1 March 2018 at 17:08, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Mar 01, 2018 at 10:28:03AM -0600, Rob Herring wrote:
> >> libfdt gained a new dependency on strrchr, so make it available to the
> >> EFI namespace before we update libfdt.
> >>
> >> Thanks to Ard for providing this fix.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> ---
> >> Please ack. This is a dependency on a dtc upstream sync.
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> >
> > As an aside, I noticed that this __efistub prefixing is also being
> > applied to mapping symbols, so we get crazy stuff like __efistub_$x. I
> > didn't get round to working out whether that's going to be problematic,
> > but maybe it's all fine...
> >
> 
> Ugh. Those mapping symbols.
> 
> We can filter them explicitly in scripts/kallsyms, I guess, or even
> better, get rid of all __efistub_ symbols entirely (since they are
> either aliases or part of __init code)

Yeah, I started hooking into frob_arch_sections, but I didn't have my ELF
hat on so I set it aside for the time being. There were some other weird
symbols that ended up in modules, some of them with unprintable characters
due to gas generating weird local labels too (I think in BUG()).

Will
