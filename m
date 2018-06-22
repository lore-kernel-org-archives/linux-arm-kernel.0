From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 22 Jun 2018 13:26:40 +0000
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile
 machine for no-MMU
In-Reply-To: <CAMuHMdXPiDGg+S3VQutSYSBwBbjW_wV+nTSBHuu7a3VNTghm1A@mail.gmail.com>
References: <20180618141905.7789-1-gerg@linux-m68k.org>
 <20180618141905.7789-5-gerg@linux-m68k.org>
 <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
 <nycvar.YSQ.7.76.1806211212010.16670@knanqh.ubzr>
 <TY1PR01MB1562B232625397CCACD5931A8A760@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdXPiDGg+S3VQutSYSBwBbjW_wV+nTSBHuu7a3VNTghm1A@mail.gmail.com>
Message-ID: <TY1PR01MB1562AFD0C247CA1A30957B1D8A750@TY1PR01MB1562.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Friday, June 22, 2018, Geert Uytterhoeven wrote:
> > 1) Modify kbuild to give the ability as stated above.
> 
> Would that actually help, or would it only give you a false feeling of
> safety?

Yup!
But I don't really care about safty. I just want to be able to build my images without having to hack Kconfig.


> Conclusion: If you want NOMMU and/or XIP, you have to know what you're
> doing,
> and hand-holding at whatever level may not save you from making mistakes.

I agree.
And, you'll require your own kernel config in order to cut out all the 
extra stuff that your system doesn't need.


> > 2) Make XIP builds somehow be able to run at multiple physical address
> > by modifying the binaries post-build (Arnd's suggestion).
> 
> That's actually an interesting one: no manual configuration (iff
> parameters
> would be extracted from the DTB), so nothing can go wrong ;-)
> I guess it applies to NOMMU, too.

For the hard coded memory address, it's only need at the very beginning 
of boot in order to set up a temporary stack, but soon the DTB is read 
and life is good. So in theory, the memory address could be passed in 
with a register.

For the hard coded ROM address, that needs to be available at run time 
in order to do the virt_to_phys translation. But, the idea is to change 
that from a #define to a global variable.

It sounded like it might work...although I never got around to hacking 
the code to see if it would or not because at the end of the day, it 
didn't provide any real value to ab XIP Linux system.


Chris
