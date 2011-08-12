From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 12 Aug 2011 18:36:24 +0900
Subject: [PATCH] arm: exynos4: Fix write to nonexistent TCMPB4 PWM register
	on samsung exynos4 platform
In-Reply-To: <4E3004E3.80003@ru.mvista.com>
References: <20110727032718.GA17800@july> <4E3004E3.80003@ru.mvista.com>
Message-ID: <007a01cc58d3$4eae47d0$ec0ad770$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote:
> 
> Hello.
> 
> On 27-07-2011 7:27, Kyungmin Park wrote:
> 
> > From: Evgeny Voevodin<e.voevodin@samsung.com>
> 
> 
> 
> > There is no TCMPB register for Pulse Width Modulation timer4 on samsung
> exynos4 board. Remove unsupported register write.
> 
> 
> 
> > Signed-off-by: Evgeny Voevodin<e.voevodin@samsung.com>
> 
> > Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
> 
> > ---
> 
> >   arch/arm/mach-exynos4/time.c |    1 -
> 
> >   1 files changed, 0 insertions(+), 1 deletions(-)
> 
> 
> 
> > diff --git a/arch/arm/mach-exynos4/time.c b/arch/arm/mach-exynos4/time.c
> 
> > index 86b9fa0..48389bf 100644
> 
> > --- a/arch/arm/mach-exynos4/time.c
> 
> > +++ b/arch/arm/mach-exynos4/time.c
> 
> > @@ -77,7 +77,6 @@ static void exynos4_pwm_init(unsigned int pwm_id,
> unsigned long tcnt)
> >
> >   		tcon |= S3C2410_TCON_T4MANUALUPD;
> >
> >
> >
> >   		__raw_writel(tcnt, S3C2410_TCNTB(4));
> >
> > -		__raw_writel(tcnt, S3C2410_TCMPB(4));
> >
> >   		__raw_writel(tcon, S3C2410_TCON);
> >
> >
> >
> >   		break;
> >
> 
>     Looks like the patch was spolied by something -- the extra new lines
were
> added after each line.
> 
Thanks, Sergei.

And this is not available now...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
