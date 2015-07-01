From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 1 Jul 2015 14:59:44 +0200
Subject: [PATCH] arm64: Don't report clear pmds and puds as huge
In-Reply-To: <CAPvkgC3qJEca1cL8DSuz5=7_xnmyKO2AQ0g+XyF+D-KmYNs9=A@mail.gmail.com>
References: <1435752511-7079-1-git-send-email-christoffer.dall@linaro.org>
 <CAPvkgC3qJEca1cL8DSuz5=7_xnmyKO2AQ0g+XyF+D-KmYNs9=A@mail.gmail.com>
Message-ID: <20150701125944.GA7625@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 01:24:34PM +0100, Steve Capper wrote:
> On 1 July 2015 at 13:08, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > The current pmd_huge() and pud_huge() functions simply check if the table
> > bit is not set and reports the entries as huge in that case.  This is
> > counter-intuitive as a clear pmd/pud cannot also be a huge pmd/pud, and
> > it is inconsistent with at least arm and x86.
> >
> > To prevent others from making the same mistake as me in looking at code
> > that calls these functions and to fix an issue with KVM on arm64 that
> > causes memory corruption due to incorrect page reference counting
> > resulting from this mistake, let's change the behavior.
> >
> > Cc: stable at vger.kernel.org
> 
> Thanks Christoffer.
> 
> It may be worth adding:
> 
> Fixes: 084bd29810a5 ("ARM64: mm: HugeTLB support.")
> 
> And, please feel free to add:
> 
> Reviewed-by: Steve Capper <steve.capper@linaro.org>
> 
Thanks!
-Christoffer
