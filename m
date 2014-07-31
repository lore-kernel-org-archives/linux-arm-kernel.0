From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jul 2014 16:15:11 +0100
Subject: [RFC] ARM: Enable dynamic clock gating?
In-Reply-To: <81f4b45a-f8b3-4dec-9e94-9028ccd3e05f@BN1AFFO11FD009.protection.gbl>
References: <81f4b45a-f8b3-4dec-9e94-9028ccd3e05f@BN1AFFO11FD009.protection.gbl>
Message-ID: <20140731151510.GZ26853@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 03:24:17PM +0100, S?ren Brinkmann wrote:
> Hi all,
> 
> similar to the patch enabling the SCU standby mode
> (https://lkml.org/lkml/2014/7/30/122), I have a patch to enable the A9's
> 'dynamic clock gating'
> (http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0388f/CIHBGEHE.html)
> in platform code. This might also be a candidate to enable in common
> code.
> Do you think that would make sense?
> I tried to find the right place to add this and was looking at
> mm/proc-v7.S. It probably works to put it there, but does not really
> seem to be the right place.
> 
> As reference, this is what I currently have as part of platform code:
>   /* A9 clock gating */
>   asm volatile ("mrc  p15, 0, r12, c15, c0, 0\n"
>                 "orr  r12, r12, #1\n"
>                 "mcr  p15, 0, r12, c15, c0, 0\n"
>                 : /* no outputs */
>                 : /* no inputs */
>                 : "r12");

This should *really* be done by firmware.

Will
