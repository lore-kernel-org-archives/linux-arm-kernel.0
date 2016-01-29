From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 29 Jan 2016 16:00:06 +0000
Subject: [PATCH 1/3] arm64: efistub: drop __init annotation from
 handle_kernel_image()
In-Reply-To: <CAKv+Gu9sE4oJrFmSK8sEjTrU8A7k53Hj1S1pTyCqyA5Gsba2Kw@mail.gmail.com>
References: <1453979254-25374-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453979254-25374-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160128225809.GF2571@codeblueprint.co.uk>
 <CAKv+Gu9sE4oJrFmSK8sEjTrU8A7k53Hj1S1pTyCqyA5Gsba2Kw@mail.gmail.com>
Message-ID: <20160129160006.GD2611@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jan, at 10:36:03AM, Ard Biesheuvel wrote:
> On 28 January 2016 at 23:58, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> >
> > Would it make more sense to #undef __init in one of the arm64 efistub
> > header files? I'm thinking of the case where some poor unsuspecting
> > developer writes a new function and marks it as __init, and we miss it
> > during review.
> >
> 
> Yes, I can add it to efistub.h, and make sure it gets included in all the files
> 
> Should we #undef it and #define it to a string that is easily grep'ed
> for, so it is easy to find the explanatory comment that goes along
> with it?
> E.g.,
> 
> #define __init __init_not_supported_in_efi_stub

This would produce a compilation failure if someone tags something as
__init right? Looks fine to me.
