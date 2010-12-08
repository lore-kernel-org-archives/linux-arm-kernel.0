From: shawn.gsc@gmail.com (Shawn Guo)
Date: Wed, 8 Dec 2010 16:27:56 +0800
Subject: [PATCH v2 04/15] ARM: mxs: Add interrupt support
In-Reply-To: <20101207210352.GC14775@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-3-git-send-email-shawn.guo@freescale.com>
	<20101207210352.GC14775@pengutronix.de>
Message-ID: <AANLkTin7jQ1uvnx1hU4Jj-j_YerKLgw=JXo6nDXmpa41@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Shawn,
>
> On Wed, Dec 08, 2010 at 12:31:54AM +0800, Shawn Guo wrote:
[...]
>> +
>> +static void icoll_ack_irq(unsigned int irq)
>> +{
>> + ? ? __raw_writel(0, icoll_base + HW_ICOLL_VECTOR);
> You need to write this before handling the irq, no? ?Note this question
> is a repetition. ?You answered "No need, indeed. ?Will remove it."
> According to MCIMX28RM a write to HW_ICOLL_VECTOR "indicates the
> in-service state". ?Are you sure this is not needed? ?If no (i.e. it's
> needed) the write should go into entry-macro.S. ?As I don't have
> hardware yet I cannot test that. ?Maybe it's only needed when the
> priority levels are used?!
>
Sorry. I made a mistake.  I thought I had tested the removal of line
and gave the comment, but actually not. The line is needed, and image
will stop working without the line.

Regarding to moving the writing to register VECTOR into entry-macro.S,
can you please help me understand the reason behind the suggestion?

-- 
Regards,
Shawn
