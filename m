From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 27 Sep 2010 02:39:44 +0200
Subject: [PATCH] ARM: s3c2442: gta02: Fix usage gpio bank j pin definitions
In-Reply-To: <4C9FE1B6.2060005@fluff.org>
References: <1285352658-20355-1-git-send-email-lars@metafoo.de>
	<4C9FE1B6.2060005@fluff.org>
Message-ID: <4C9FE7D0.8030804@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
> On 24/09/10 19:24, Lars-Peter Clausen wrote:
>> The gta02 header file still uses the old S3C2410_GPJx defines instead of the
>> S3C2410_GPJ(x) macro. Since the S3C2410_GPJx defines have already been removed
>> this causes a build failure.
>> This patches fixes the issue by doing a s,S3C2410_GPJ([\d]+),S3C2410_GPJ(\1),g
>> on the file.
> 
> Is this currently causing a build error? If so, please add the snippet
> of the build log. Otherwise it'll get queued for the next merge.


  CC      sound/soc/s3c24xx/neo1973_gta02_wm8753.o
sound/soc/s3c24xx/neo1973_gta02_wm8753.c: In function 'lm4853_set_spk':
sound/soc/s3c24xx/neo1973_gta02_wm8753.c:244: error: 'S3C2440_GPJ2' undeclared (first
use in this function)
sound/soc/s3c24xx/neo1973_gta02_wm8753.c:244: error: (Each undeclared identifier is
reported only once
sound/soc/s3c24xx/neo1973_gta02_wm8753.c:244: error: for each function it appears in.)
sound/soc/s3c24xx/neo1973_gta02_wm8753.c: In function 'lm4853_event':
sound/soc/s3c24xx/neo1973_gta02_wm8753.c:265: error: 'S3C2440_GPJ1' undeclared (first
use in this function)
sound/soc/s3c24xx/neo1973_gta02_wm8753.c:265: error: 'value' undeclared (first use in
this function)
sound/soc/s3c24xx/neo1973_gta02_wm8753.c: In function 'neo1973_gta02_init':
sound/soc/s3c24xx/neo1973_gta02_wm8753.c:458: error: 'S3C2440_GPJ2' undeclared (first
use in this function)
sound/soc/s3c24xx/neo1973_gta02_wm8753.c:464: error: 'GTA02_GPIO_AMP_HP_IN'
undeclared (first use in this function)
sound/soc/s3c24xx/neo1973_gta02_wm8753.c:470: error: 'S3C2440_GPJ1' undeclared (first
use in this function)
sound/soc/s3c24xx/neo1973_gta02_wm8753.c: In function 'neo1973_gta02_exit':
sound/soc/s3c24xx/neo1973_gta02_wm8753.c:498: error: 'S3C2440_GPJ2' undeclared (first
use in this function)
sound/soc/s3c24xx/neo1973_gta02_wm8753.c:499: error: 'S3C2440_GPJ1' undeclared (first
use in this function)
