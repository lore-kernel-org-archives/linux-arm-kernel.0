From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 3 Jun 2010 10:00:43 +0200
Subject: [PATCH 0/5] Makefile.boot cleanup
In-Reply-To: <AANLkTim-U76fy_N6bfhJ0BFihDrW1YEcJXDyEqtajc8c@mail.gmail.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<AANLkTim-U76fy_N6bfhJ0BFihDrW1YEcJXDyEqtajc8c@mail.gmail.com>
Message-ID: <20100603080043.GC336@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Thu, Jun 03, 2010 at 03:43:30PM +0800, Eric Miao wrote:
> On Thu, Jun 3, 2010 at 3:36 PM, Eric Miao <eric.miao@canonical.com> wrote:
> > Several facts:
> >
> > 1. ZRELADDR in most cases can be auto detected by maksing PC with
> > ? 0xf000_0000 if the zImage is placed within the first 256MiB from
> > ? the memory start, which is a sane assumption except for:
> >
> > ? - when ARCH_MX1 or ARCH_SHARK is defined
> > ? - when ARCH_U300 is defined (U300 really is strange when defining
> > ? ? PHYS_OFFSET and ZRELADDR)
> > ? - or when ZBOOT_ROM is defined
> >
> 
> And maybe we could restrict the assumption to 128MB, so that MX1
> and SHARK can be included as well.
I used 128 MiB, too.  When I did it I found "problems" for s3c2400 and
at91.  For the latter physoffset depended on .config.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
