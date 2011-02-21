From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Feb 2011 18:58:25 +0900
Subject: [PATCH 01/09] ARM: s3c2442: gta02: Fix usage gpio bank j pin
	definitions
In-Reply-To: <4D5E4CC1.1010705@metafoo.de>
References: <1297043521-21903-1-git-send-email-lars@metafoo.de>
	<4D5E4CC1.1010705@metafoo.de>
Message-ID: <000101cbd1ad$e658d580$b30a8080$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lasrs-Peter Clausen wrote:
> 
> On 02/07/2011 02:51 AM, Lars-Peter Clausen wrote:
> > The gta02 header file still uses the old S3C2410_GPJx defines instead of
> the
> > S3C2410_GPJ(x) macro. Since the S3C2410_GPJx defines have already been
> removed
> > this causes the following build failure:
> >
> > 	sound/soc/samsung/neo1973_wm8753.c: In function 'lm4853_set_spk':
> > 	sound/soc/samsung/neo1973_wm8753.c:259: error: 'S3C2440_GPJ2'
> undeclared (first use in this function)
> > 	sound/soc/samsung/neo1973_wm8753.c:259: error: (Each undeclared
> identifier is reported only once
> > 	sound/soc/samsung/neo1973_wm8753.c:259: error: for each function it
> appears in.)
> > 	sound/soc/samsung/neo1973_wm8753.c: In function 'lm4853_get_spk':
> > 	sound/soc/samsung/neo1973_wm8753.c:267: error: 'S3C2440_GPJ2'
> undeclared (first use in this function)
> > 	sound/soc/samsung/neo1973_wm8753.c: In function 'lm4853_event':
> > 	sound/soc/samsung/neo1973_wm8753.c:276: error: 'S3C2440_GPJ1'
> undeclared (first use in this function)
> > 	sound/soc/samsung/neo1973_wm8753.c: At top level:
> > 	sound/soc/samsung/neo1973_wm8753.c:439: error: 'S3C2440_GPJ2'
> undeclared here (not in a function)
> > 	sound/soc/samsung/neo1973_wm8753.c:440: error: 'S3C2440_GPJ1'
> undeclared here (not in a function)
> >
> > This patches fixes the issue by doing a
> s,S3C2410_GPJ([\d]+),S3C2410_GPJ(\1),g
> > on the file.
> >
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> 
> Hi
> 
> Ben or Kukjin could you take a look at this series and merge it, if it is
ok?
> 
Hi Lars-Peter,

Basically, the maintainer of mach-s3c* is Ben Dooks.
I think, he will review this series but if he can't soon, I will/can do it.

Ben, could you please review this patches?
If you're busy, please let me know :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
