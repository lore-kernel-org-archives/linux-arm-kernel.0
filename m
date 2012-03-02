From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 2 Mar 2012 16:40:55 -0500 (EST)
Subject: [RFC PATCH 0/2] ARM: assembler: Add uniform assembler
 framework
In-Reply-To: <20120301114942.GA2040@linaro.org>
References: <1330455586-10353-1-git-send-email-dave.martin@linaro.org>
 <20120228192458.GC3617@n2100.arm.linux.org.uk>
 <20120301114942.GA2040@linaro.org>
Message-ID: <alpine.LFD.2.02.1203021633530.31242@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Mar 2012, Dave Martin wrote:

> I have a workaround for the above now, but it's not pretty -- I seem to
> have opened a can of worms here.
> 
> 
> We would need something like
> 
> #define EXTENDED_ASM(stuff) asm ( ".include \"macros.inc\"\n\t" stuff )
> #define EXTENDED_VASM(stuff) asm volatile ( ".include \"macros.inc\"\n\t" stuff )
> 
> ...where macros.inc includes some logic to protect against multiple
> inclusion.
> 
> This would avoid problems caused by reordering done by the compiler.
> 
> I think this can work, but it may be a step too far...
> 
> 
> The above could help fix the incorrect way that asm/unified.h defines
> the it* macros (though admittedly that does not seem to have caused
> problems for anyone so far...)

"If it aint broken dont fix it."

Yes, we might be making assumptions that are not guaranteed by the tools 
here, but as long as you make sure that some assumption going wrong 
won't go unnoticed and produce a broken binary then it is probably fine.

I did like your initial approach better, even if there is a risk that 
future tools might break it.  At least there was very little chances for 
the build to succeed if the global asm macros are not defined early 
enough.


Nicolas
