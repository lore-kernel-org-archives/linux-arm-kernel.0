From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 21 Nov 2011 14:43:33 +0000
Subject: [PATCH] ARM: sa1100: refactor sa1100 serial driver
In-Reply-To: <4ECA6235.4030108@scram.de>
References: <1321821127-32231-1-git-send-email-jochen@scram.de>
 <1321822068.17619.3.camel@Joe-Laptop> <4ECA6235.4030108@scram.de>
Message-ID: <20111121144333.GA25627@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 03:37:41PM +0100, Jochen Friedrich wrote:
> Hi Joe,
> 
> >trivia:
> >
> >>diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
> >[]
> >>@@ -166,7 +166,7 @@ static struct platform_device sa11x0udc_device = {
> >>  static struct resource sa11x0uart1_resources[] = {
> >>  	[0] = {
> >>  		.start	= __PREG(Ser1UTCR0),
> >>-		.end	= __PREG(Ser1UTCR0) + 0xffff,
> >>+		.end	= __PREG(Ser1UTCR0) + 0x24,
> >
> >#define for 0x24? or is it really 0x23?
> >(start + size - 1)
> 
> Thanks, I'll fix this.

It may even be worth looking at the DEFINE_RES_MEM() type macros in 
include/linux/ioport.h, but I'm not sure that's essential!

Jamie
