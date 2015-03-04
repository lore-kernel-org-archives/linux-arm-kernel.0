From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 Mar 2015 17:34:16 +0000
Subject: [PATCH] ARM: advertise availability of v8 Crypto instructions
In-Reply-To: <20150304172353.GC8656@n2100.arm.linux.org.uk>
References: <1425054991-29951-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_dSgtsUp8aeMwz9a6stEC3DCg8GMU5QWWTPy_oOyHCSw@mail.gmail.com>
 <20150304162049.GX28951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-pSOMFhSs=AeAERU1=XKU3xsBJCBOedVnZYBg6frWN9A@mail.gmail.com>
 <20150304170404.GZ28951@e104818-lin.cambridge.arm.com>
 <20150304172353.GC8656@n2100.arm.linux.org.uk>
Message-ID: <20150304173415.GB28951@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 05:23:53PM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 04, 2015 at 05:04:05PM +0000, Catalin Marinas wrote:
> > On Wed, Mar 04, 2015 at 05:31:00PM +0100, Ard Biesheuvel wrote:
> > > It doesn't really matter which architecture it is. I just want to be
> > > reasonably sure that reading ID_ISAR5 isn't going to explode. If there
> > > are other/better ways to guarantee that, I am happy to use those as
> > > well. (I noticed that there is a v7-M specific definition of ID_ISAR5
> > > in the source which I couldn't find any reference to in any of the
> > > Cortex-M TRMs on the infocenter web site.)
> > 
> > The ARMv7-M reference manual only defines to ID_ISAR4. Maybe it will get
> > a fifth register at some point but for now I don't think we should read
> > it (I guess it was just copy/paste from the A profile).
> 
> I think you need to read carefully the requirements that are placed
> upon non-implemented CPUID registers.
> 
> In DDI0406C, non-implemented CPUID registers are reserved, but must
> behave as RAZ.  I would be very surprised if this were not true for
> ARMv7-M.

At a second search, I found ID_ISAR5 as reserved in the registers
summary table. So, I agree, it should be RAZ, so safe to read (I thought
ID_ISAR5 would not be present at all).

-- 
Catalin
