From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 20 Oct 2010 16:34:46 +0900
Subject: [PATCH v2] ARM: S3C64XX: add support for mach-mini6410
In-Reply-To: <4CBDD33B.5000007@gmail.com>
References: <20101019171009.11315.47694.stgit@darius-desktop>
	<4CBDD33B.5000007@gmail.com>
Message-ID: <05c501cb7029$4734e510$d59eaf30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Darius Augulis wrote:
> 
> Kukjin,
> 
> please replace old patch in my previously sent series with this new one.
> Other I think should be OK. Could you please add this series to your
> tree? I'm afraid it's too late to have it in 2.3.37 even thought I sent
> them early enough.
> 
Don't worry about that. :-)

> Thanks,
> Darius
> 
> 
> On 10/19/2010 08:11 PM, Darius Augulis wrote:
> > Add support for mini6410 board from FriendlyARM
> >
> > Signed-off-by: Darius Augulis<augulis.darius@gmail.com>
> > ---
> >
> > Changelog since v1:
> >   - Removed .phys_io and .io_pg_offst from MACHINE_START
> >

(snip)

> > +
> > +MACHINE_START(MINI6410, "MINI6410")
> > +	/* Maintainer: Darius Augulis<augulis.darius@gmail.com>  */
> > +	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
> > +	.init_irq	= s3c6410_init_irq,
> > +	.map_io		= mini6410_map_io,
> > +	.init_machine	= mini6410_machine_init,
> > +	.timer		=&s3c24xx_timer,
> > +MACHINE_END

Russell,

I'm confusing about commit 861bd81ee62a0d6759144c22909a8a3938951656 ("arm:
remove machine_desc.io_pg_offst and .phys_io") because couldn't find it in
your -devel and -master.

Anyway...should I remove .io_pg_offst and .phys_io of missed stuff from
commit 861bd81 like this which will be merged in the -next in my tree?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
