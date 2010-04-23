From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 23 Apr 2010 14:56:18 +0300
Subject: [PATCH v2] MTD: Fix Orion NAND driver compilation with ARM OABI
In-Reply-To: <4BB33988.9070608@gmail.com>
References: <20100325152505.17612.40158.stgit@pauliusz>
	<alpine.LFD.2.00.1003251225500.694@xanadu.home>
	<4BB33988.9070608@gmail.com>
Message-ID: <1272023778.6917.6.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-03-31 at 15:01 +0300, Paulius Zaleckas wrote:
> On 03/25/2010 06:26 PM, Nicolas Pitre wrote:
> > On Thu, 25 Mar 2010, Paulius Zaleckas wrote:
> >
> >> We must tell GCC to use even register for variable passed
> >> to ldrd instruction. Without this patch GCC 4.2.1 puts this
> >> variable to r2/r3 on EABI and r3/r4 on OABI, so force it to
> >> r2/r3. This does not change anything when EABI and OABI
> >> compilation works OK.
> >>
> >> Without this patch and with OABI I get:
> >>    CC      drivers/mtd/nand/orion_nand.o
> >> /tmp/ccMkwOCs.s: Assembler messages:
> >> /tmp/ccMkwOCs.s:63: Error: first destination register must be even -- `ldrd r3,[ip]'
> >> make[5]: *** [drivers/mtd/nand/orion_nand.o] Error 1
> >>
> >> Signed-off-by: Paulius Zaleckas<paulius.zaleckas@gmail.com>
> >
> > Acked-by: Nicolas Pitre<nico@fluxnic.net>
> 
> David,
> 
> Will you take this patch?
> Or you are waiting till I will add all Cc as Jamie suggested?

Meanwhile, I've pushed your patch to my l2-mtd-2.6.git / dunno.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
