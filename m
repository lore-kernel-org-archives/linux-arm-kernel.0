From: msalter@redhat.com (Mark Salter)
Date: Thu, 11 Dec 2014 14:11:09 -0500
Subject: arm64 hitting BUG in arch_timer.h
In-Reply-To: <5489E9DA.8000504@cogentembedded.com>
References: <1418245000.23374.26.camel@t520.localdomain>
 <5489E9DA.8000504@cogentembedded.com>
Message-ID: <1418325069.23374.31.camel@t520.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-12-11 at 22:00 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 12/10/2014 11:56 PM, Mark Salter wrote:
> 
> > Using Linus' tree from this morning, I am hitting:
> 
> >     [    0.000000] BUG: failure at ./arch/arm64/include/asm/arch_timer.h:112/arch_counter_get_cntpct!
> 
> > This is triggered by commit 0b46b8a718 ("clocksource: arch_timer: Fix
> > code to use physical timers when requested") which addresses an armv7
> > problem. Arm64 wants to always use a virtual timer. I used this to avoid
> > the BUG and get a booting kernel:
> 
>     You didn't sign off on the patch, so it can't be applied.
> 
> [...]
> 
> WBR, Sergei
> 

Right. That was more for discussion. I wasn't sure if that was the best
way to fix the problem so I just included what I did to work around it.
As it turns out, I wasn't the first to spot the problem or come up with
a patch. So, the first patch will go in without my further involvement.
