From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 3 Jun 2010 09:57:04 +0200
Subject: [PATCH 0/5] Makefile.boot cleanup
In-Reply-To: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
Message-ID: <20100603075704.GB336@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

On Thu, Jun 03, 2010 at 03:36:48PM +0800, Eric Miao wrote:
> Several facts:
> 
> 1. ZRELADDR in most cases can be auto detected by maksing PC with
>    0xf000_0000 if the zImage is placed within the first 256MiB from
>    the memory start, which is a sane assumption except for:
> 
>    - when ARCH_MX1 or ARCH_SHARK is defined
>    - when ARCH_U300 is defined (U300 really is strange when defining
>      PHYS_OFFSET and ZRELADDR)
>    - or when ZBOOT_ROM is defined
If you guess ZRELADDR based on sp instead of pc it even should work if
ZBOOT_ROM is defined?!

That's how I did it in
http://git.pengutronix.de/?p=ukl/linux-2.6.git;a=commit;h=booting/pu

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
