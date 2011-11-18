From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Nov 2011 19:46:00 +0000
Subject: [PATCH 18/41] ARM: restart: ixp4xx: use new restart hook
In-Reply-To: <m339dlsweq.fsf@intrepid.localdomain>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6nE-0001Xl-8i@rmk-PC.arm.linux.org.uk>
 <20111117173027.GE9581@n2100.arm.linux.org.uk>
 <m339dlsweq.fsf@intrepid.localdomain>
Message-ID: <20111118194600.GK9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 08:49:01AM +0100, Krzysztof Halasa wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> >> Hook these platforms restart code into the new restart hook rather
> >> than using arch_reset().
> 
> Looks good basically, except a detail:
> 
> >> --- a/arch/arm/mach-ixp4xx/common.c
> >> +++ b/arch/arm/mach-ixp4xx/common.c
> >> @@ -500,3 +500,23 @@ static void __init ixp4xx_clockevent_init(void)
> >>  
> >>  	clockevents_register_device(&clockevent_ixp4xx);
> >>  }
> >> +
> >> +void ixp4xx_restart(char mode, const char *cmd)
> >> +{
> >> +	if ( 1 && mode == 's') {
>            ^^^^^^^
> This one. Yeah, I can see where does it come from.

It's weird, I suspect it was supposed to be 1 || there, but I've no idea
what the intention is there.  So I left the code as-is.

> Otherwise,
> Acked-by: Krzysztof Ha?asa <khc@pm.waw.pl>

I'm going to assume that applies to this version - because I think fixing
that should be done independently of this patch series.

> >> +		/* Jump into ROM at address 0 */
> >> +		soft_restart(0);
> 
> OTOH I probably need to investigate this soft_restart, "when time
> permits", that's another story of course.
> -- 
> Krzysztof Halasa
