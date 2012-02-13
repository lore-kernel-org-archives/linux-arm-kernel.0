From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 13 Feb 2012 11:07:30 +0000
Subject: Question on ARM Cortex R4 support in Linux
In-Reply-To: <CAPub1482HL66wX92Oc7Vu75QaweOEd3k2S757mx513GueSkurA@mail.gmail.com>
References: <CAPub149OKvBUiKoOie9BmKYfopB7L0_J1fSx2Nh-aRXr99RPaQ@mail.gmail.com>
 <20120213105313.GD4994@arm.com>
 <CAPub1482HL66wX92Oc7Vu75QaweOEd3k2S757mx513GueSkurA@mail.gmail.com>
Message-ID: <20120213110730.GA7375@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 10:59:50AM +0000, shiraz hashim wrote:
> Hi Catalin,
> 
> On Mon, Feb 13, 2012 at 4:23 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Mon, Feb 13, 2012 at 10:49:18AM +0000, shiraz hashim wrote:
> >> We plan to use Linux on our Cortex R4 based SoC.
> >> Can we use the latest Linux straight away or do we
> >> require to add some support for it.
> >>
> >> I went through www.linux-arm.org/LinuxKernel/LinuxM3
> >> which describes Cortex M3 support in Linux but was not
> >> able to find any information on M4.
> >
> > Do you mean M4 or R4 here?
> 
> I am interested in R4 but was just thinking that M4 support can work
> for R4 as well.

M4 and R4 are completely different processor classes. R4 is supported
pretty much by default in !MMU Linux as it's close to the A class (same
exception model). The M class has a completely different exception model
and it only supports the Thumb-2 instruction set.

> >> Has anybody used it on Cortex R4 based platform ?
> >
> > In theory Linux support for R4 should just work (once CONFIG_MMU is
> > disabled). I used to test it in the past regularly but not recently.
> 
> Great. I was planning to use linux-3.2, I hope the support is there ?

It's been there for years, but some bit-rotting may have occurred.

-- 
Catalin
