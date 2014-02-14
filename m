From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Feb 2014 19:23:22 +0000
Subject: [PATCH v3] ARM: mm: report both sections from PMD
In-Reply-To: <CAGXu5jKYq=0Ud-A6bdD2zMe=+r0S7nja8Rg+OxeT+JHzdpwTKg@mail.gmail.com>
References: <20140213195230.GA15275@www.outflux.net>
 <20140214101724.GC10590@arm.com>
 <CAGXu5jKYq=0Ud-A6bdD2zMe=+r0S7nja8Rg+OxeT+JHzdpwTKg@mail.gmail.com>
Message-ID: <20140214192322.GJ30257@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 11:13:53AM -0800, Kees Cook wrote:
> On Fri, Feb 14, 2014 at 2:17 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Thu, Feb 13, 2014 at 07:52:30PM +0000, Kees Cook wrote:
> >> On 2-level page table systems, the PMD has 2 section entries. Report
> >> these, otherwise ARM_PTDUMP will miss reporting permission changes on
> >> odd section boundaries.
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> On Fri, Feb 14, 2014 at 9:05 AM, Steve Capper <steve.capper@linaro.org> wrote:
> > Tested-by: Steve Capper <steve.capper@linaro.org>
> 
> Thanks to both of you! If you have a moment can you check this other
> patch which has additional fixes for the dump code?
> 
> https://lkml.org/lkml/2014/2/12/662

It's not that simple, because APX in section descriptors doesn't exist
on pre-v6 ARMs.  This needs to be conditional upon the CPU arch.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
