From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 24 May 2013 07:11:04 +0000
Subject: [PATCH] ARM: at91: Fix: Change internal SRAM memory type to
 "MT_MEMORY_SO"
In-Reply-To: <20130522001457.GA18614@n2100.arm.linux.org.uk>
References: <1369011911-21282-1-git-send-email-wenyou.yang@atmel.com>
 <1369011979-21354-1-git-send-email-wenyou.yang@atmel.com>
 <20130522001457.GA18614@n2100.arm.linux.org.uk>
Message-ID: <B256D81BAE5131468A838E5D7A243641687BB93C@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: 2013?5?22? 8:15
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> plagnioj at jcrosoft.com; Ferre, Nicolas; linux at maxim.org.za
> Subject: Re: [PATCH] ARM: at91: Fix: Change internal SRAM memory type to
> "MT_MEMORY_SO"
> 
> On Mon, May 20, 2013 at 09:06:19AM +0800, Wenyou Yang wrote:
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> 
> This needs more of a description.  Also, for a single patch, it's silly
> to send two mails, the first being a cover which has a little more
> information in it about the patch than the patch itself.
> 
> You need to explain _why_ you're making this change.  What I want to see
> is that you've thought about the implications of this - particularly that
> you know that strongly ordered memory does *not* imply any ordering with
> any other memory types.
> 
> In other words, I want to know that this change is not a bodge but there's
> a real reason behind it.
The story is: for sama5d3x with Cortex-A5 core, if not so, when copying code snippet to the internal SRAM, then jump to run this code, but fail to run.
So, refer to other code(such as omap4), do such change. I also test it on at91sam9 with 926ej-s core.
As what you said, I am digging it. Thank you very much.

Best Regards,
Wenyou Yang
