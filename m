From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 11 Nov 2010 12:24:16 -0800
Subject: [PATCH] ARM: Common GIC entry macro code V2
In-Reply-To: <20101111074955.29633.80160.sendpatchset@t400s>
References: <20101111074955.29633.80160.sendpatchset@t400s>
Message-ID: <1289507056.18994.13.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-11-11 at 16:49 +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch is the identical GIC demux implementation
> merge V2. Instead of implementing same code over and
> over simply share it in entry-macro-gic.S. The shared
> code is based on the realview implementation.
> 
> Each GIC demux instance still has to setup the base address
> of the controller using the get_irqnr_preamble macro. The
> rest of the GIC specific code can be shared.
> 
> The omap code is excluded due to complexity and lack of
> hardware - the CONFIG_SMP macros are used for multi-omap
> and the omap4 case - this makes is difficult to share code.
> 
> The s5pv310 subarch is excluded due to the special "addne"
> instruction in the get_irqnr_and_base macro.
> 
> The msm subarch is excluded as well since it treats PPIs
> differently than other platforms and needs a different
> version of the get_irqnr_and_base macro.

I'm a little disappoint you didn't CC someone MSM related on this. Your
patch is small enough that you can CC everyone effected. Here's
get_maintainer.pl output on it,

Russell King <linux@arm.linux.org.uk>
Anton Vorontsov <avorontsov@mvista.com>
Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Linus Walleij <linus.walleij@stericsson.com>
Alessandro Rubini <rubini@unipv.it>
linux-arm-kernel at lists.infradead.org
linux-kernel at vger.kernel.org

At least those people should be getting this. Also, why can't you break
this up per sub-architecture ?

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
