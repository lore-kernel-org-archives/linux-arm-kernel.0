From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 25 Aug 2017 10:10:23 +0900
Subject: [PATCH 08/14] arm64: kexec_file: create purgatory
In-Reply-To: <CAKv+Gu9UUF-36iEkpsweOAPKOX8nQcoRy1+ushr6GTJiUC6fKg@mail.gmail.com>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-9-takahiro.akashi@linaro.org>
 <CAKv+Gu9UUF-36iEkpsweOAPKOX8nQcoRy1+ushr6GTJiUC6fKg@mail.gmail.com>
Message-ID: <20170825011022.GA7245@akashi-kouhiroshi-no-MacBook-Air.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 10:10:37AM +0100, Ard Biesheuvel wrote:
> On 24 August 2017 at 09:18, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> > This is a basic purgtory, or a kind of glue code between the two kernel,
> > for arm64. We will later add a feature of verifying a digest check against
> > loaded memory segments.
> >
> > arch_kexec_apply_relocations_add() is responsible for re-linking any
> > relative symbols in purgatory. Please note that the purgatory is not
> > an executable, but a non-linked archive of binaries so relative symbols
> > contained here must be resolved at kexec load time.
> 
> This sounds fragile to me. What is the reason we cannot let the linker
> deal with this, similar to, e.g., how the VDSO gets linked?

Please note this is exactly what x86 code does.
I guess that the reason is that x86 guys borrowed the logic directly
from kexec-tools.

> Otherwise, couldn't we reuse the module loader to get these objects
> relocated in memory? I'm sure there are differences that would require
> some changes there, but implementing all of this again sounds like
> overkill to me.

I'll look at both of your suggestions.

Thanks,
-Takahiro AKASHI
