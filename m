From: horms@verge.net.au (Simon Horman)
Date: Wed, 22 May 2013 22:56:13 +0900
Subject: [PATCH] ARM: shmobile: kzm9g-reference: Update CMT clocksource
 rating to 80
In-Reply-To: <519CCB97.20207@cogentembedded.com>
References: <1369226980-16203-1-git-send-email-horms+renesas@verge.net.au>
 <519CCB97.20207@cogentembedded.com>
Message-ID: <20130522135608.GA32012@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 05:43:51PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 22-05-2013 16:49, Simon Horman wrote:
> 
> >Update the CMT clocksource rating from 100 to 10.
> 
>    s/100/125/ and s/10/80/, apparently.

Thanks, I don't know what I was thinking.

> 
> >This resolves a boot-failure regression for kzm9g-reference in v3.10-rc1
> >introduced by f7db706b132f11c79ae1d74b2382e0926cf31644 ("ARM: 7674/1: smp:
> >Avoid dummy clockevent being preferred over real").
> 
> >The patch noted above reduces the rating of dummy clockevent from 400 to 100.
> 
>    400 seems very high rating for a dummy clockevent...
> 
> >This patch reduces the rating of CMT so that it is once again less than that
> >of the dummy clockevent.
> 
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> >---
> 
> >I also plan to reduce the rating of the STI clocksource to less than 100.
> >However, as I am not aware of any problems relating to STI in v3.10-rc
> >my plan is to update STI in the v3.11 timeframe.
> >---
> >  arch/arm/mach-shmobile/setup-sh73a0.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> >diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
> >index fdf3894..9696f36 100644
> >--- a/arch/arm/mach-shmobile/setup-sh73a0.c
> >+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> >@@ -252,7 +252,7 @@ static struct sh_timer_config cmt10_platform_data = {
> >  	.name = "CMT10",
> >  	.channel_offset = 0x10,
> >  	.timer_bit = 0,
> >-	.clockevent_rating = 125,
> >+	.clockevent_rating = 80,
> >  	.clocksource_rating = 125,
> >  };
> 
> WBR, Sergei
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
