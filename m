From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 1 Oct 2009 20:32:48 +0200
Subject: [PATCH 1/4] Made VMALLOC_END of type unsigned long.
In-Reply-To: <20091001130338.GB26910@n2100.arm.linux.org.uk>
References: <1245155890204-git-send-email-andreas.fenkart@streamunlimited.com>
	<20090619094640.GD22234@n2100.arm.linux.org.uk>
	<20091001104715.GA25067@CCCP>
	<20091001130338.GB26910@n2100.arm.linux.org.uk>
Message-ID: <20091001183248.GD27288@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Oct 01, 2009 at 02:03:38PM +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 01, 2009 at 12:47:15PM +0200, Andreas Fenkart wrote:
> > Davinci defines VMALLOC_END this way:
> > 
> > #define VMALLOC_END   (IO_VIRT - (2<<20))   
> > 
> > The simple solution would be to prefix the VMALLOC_END with UL,
> > the alternative to make IO_VIRT unsinged long.
> 
> Is:
> 
> 	(IO_VIRT - (2<<20))UL
> 
> valid C?  I don't think it is, and neither does my compiler.
No, but

	 UL(IO_VIRT - (2<<20))

might work?!  Havn't tried though.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
